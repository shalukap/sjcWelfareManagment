<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\FeeAssignment;
use App\Models\Student;
use Illuminate\Support\Facades\DB;

class FeeAssignmentController extends Controller
{

public function search()
{
    return Inertia::render('FeeAssignments/SearchStudent');
}
    /**
     * Display a listing of fee assignments with search functionality.
     */
    public function index(Request $request)
    {
        $search = $request->input('search', '');

        $feeAssignments = FeeAssignment::with('student')
            ->when($search, function ($query, $search) {
                $query->whereHas('student', function ($q) use ($search) {
                    $q->where('admission_number', 'like', "%{$search}%")
                      ->orWhere('name', 'like', "%{$search}%")
                      ->orWhere('current_grade', 'like', "%{$search}%");
                });
            })
            ->orderBy('academic_year', 'desc')
            ->orderBy('student_id')
            ->get();

        return Inertia::render('FeeAssignments/Index', [
            'feeAssignments' => $feeAssignments,
            'search' => $search
        ]);
    }

    /**
     * Show the form for creating a new fee assignment for a specific grade.
     */
    public function createGrade()
    {
        $grades = Student::distinct()->pluck('current_grade')->filter()->values();

        return Inertia::render('FeeAssignments/CreateGrade', [
            'grades' => $grades
        ]);
    }

    /**
     * Store fee assignments for all students in a specific grade and academic year.
     */
    public function storeGrade(Request $request)
    {
        $validated = $request->validate([
            'academic_year' => 'required|string|max:4',
            'grade' => 'required|string',
            'assigned_fee' => 'required|numeric|min:0',
        ]);

        $students = Student::where('current_grade', $validated['grade'])
            ->where('is_active', true)
            ->get();

        if ($students->isEmpty()) {
            return redirect()->back()
                ->with('error', 'No active students found in grade ' . $validated['grade']);
        }

        DB::beginTransaction();

        try {
            $created = 0;
            $skipped = 0;

            foreach ($students as $student) {
                $existingAssignment = FeeAssignment::where('student_id', $student->id)
                    ->where('academic_year', $validated['academic_year'])
                    ->first();

                if (!$existingAssignment) {
                    FeeAssignment::create([
                        'student_id' => $student->id,
                        'academic_year' => $validated['academic_year'],
                        'assigned_fee' => $validated['assigned_fee'],
                        'adjusted_fee' => $validated['assigned_fee'],
                        'adjustment_reason' => null,
                        'status' => 'Unpaid'
                    ]);
                    $created++;
                } else {
                    $skipped++;
                }
            }

            DB::commit();

            $message = "Fee assignments created for $created student(s)";
            if ($skipped > 0) {
                $message .= ". Skipped $skipped student(s) with existing assignments";
            }

            return redirect()->route('fee-assignments.index')
                ->with('success', $message);

        } catch (\Exception $e) {
            DB::rollBack();

            return redirect()->back()
                ->with('error', 'Failed to create fee assignments: ' . $e->getMessage());
        }
    }

    /**
     * Show the form for adjusting an individual student's fee.
     */
    public function edit($id)
    {
        $feeAssignment = FeeAssignment::with('student')->findOrFail($id);

        return Inertia::render('FeeAssignments/Edit', [
            'feeAssignment' => $feeAssignment
        ]);
    }

    /**
     * Update an individual student's fee assignment with adjustment.
     */
    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'adjusted_fee' => 'required|numeric|min:0',
            'adjustment_reason' => 'nullable|string|max:500',
        ]);

        $feeAssignment = FeeAssignment::findOrFail($id);

        $feeAssignment->update([
            'adjusted_fee' => $validated['adjusted_fee'],
            'adjustment_reason' => $validated['adjustment_reason']
        ]);

        return redirect()->route('fee-assignments.index')
            ->with('success', 'Fee assignment updated successfully');
    }

    /**
     * Remove the specified fee assignment.
     */
    public function destroy($id)
    {
        $feeAssignment = FeeAssignment::findOrFail($id);
        $feeAssignment->delete();

        return redirect()->route('fee-assignments.index')
            ->with('success', 'Fee assignment deleted successfully');
    }

    /**
     * Show form to search for a student's fee assignments by admission number.
     */
    public function searchStudent()
    {
        return Inertia::render('FeeAssignments/SearchStudent');
    }

    /**
     * Get fee assignments for a specific student by admission number.
     */
    public function getStudentAssignments(Request $request)
    {
        $validated = $request->validate([
            'admission_number' => 'required|string'
        ]);

        $student = Student::where('admission_number', $validated['admission_number'])->first();

        if (!$student) {
            return redirect()->back()
                ->with('error', 'Student not found with admission number: ' . $validated['admission_number']);
        }

        $feeAssignments = FeeAssignment::with('student')
            ->where('student_id', $student->id)
            ->orderBy('academic_year', 'desc')
            ->get();

        return Inertia::render('FeeAssignments/StudentAssignments', [
            'student' => $student,
            'feeAssignments' => $feeAssignments
        ]);
    }
}
