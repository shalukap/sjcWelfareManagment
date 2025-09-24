<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

use App\Models\Student;

class StudentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $students = Student::all();
        return Inertia::render('Students/Index', [
            'students' => $students
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
    return Inertia::render('Students/Form');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'admission_number' => 'required|unique:students',
            'name' => 'required',
            'whatsapp_number' => 'nullable',
            'current_grade' => 'required',
            'current_class' => 'required',
            'is_active' => 'boolean',
            'sibling_admission_no' => 'nullable|exists:students,admission_number',
        ]);
    Student::create($validated);
    return redirect()->route('students.index')->with('success', 'Student created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {

    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $student = Student::findOrFail($id);
        return Inertia::render('Students/Form', [
            'student' => $student,
            'isEdit' => true
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $student = Student::findOrFail($id);
        $validated = $request->validate([
            'admission_number' => 'required|unique:students,admission_number,' . $student->id,
            'name' => 'required',
            'whatsapp_number' => 'nullable',
            'current_grade' => 'required',
            'current_class' => 'required',
            'is_active' => 'boolean',
            'sibling_admission_no' => 'nullable|exists:students,admission_number',
        ]);
        $student->update($validated);
        return redirect()->route('students.index')->with('success', 'Student updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
    $student = Student::findOrFail($id);
    $student->delete();
    return redirect()->route('students.index')->with('success', 'Student deleted successfully');
    }
}
