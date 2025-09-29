<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Student;
use App\Models\FeeAssignment;
use Spatie\Browsershot\Browsershot;

class DueReportsController extends Controller
{
    public function index()
    {
        return Inertia::render('DueReport/index');
    }
    public function generateDueReport(Request $request){
        $grade=$request->grade;           
        $class=$request->class;      
       
        
        /*
        
        $students=$studentQuery->whereHas('feeAssignments', function ($query) {
            $query->where(function($q){
                $q->where('status', 'Unpaid')->orWhere('status', 'Partially Paid');
            });
        })->with(['feeAssignments' => function ($query) {
            $query->where(function($q){
                $q->where('status', 'Unpaid')->orWhere('status', 'Partially Paid');
            });
        }])->get();
       */

        $studentQuery = Student::query()
        ->where('current_grade', $grade)         
        ->where('is_active', true)
        ->whereHas('feeAssignments', function ($q) {
            $q->whereIn('status', ['Unpaid', 'Partially Paid']);
        })
        ->with(['feeAssignments' => function ($q) {
            $q->whereIn('status', ['Unpaid', 'Partially Paid'])
              ->with('payments');
        }]);
       
        
        if ($class !== 'ALL') {
        $studentQuery->where('current_class', $class);
        }
       
        $students = $studentQuery->get();
        
       
       
        $studentsWithDue = $students->map(function ($student) {
        $dueAmount = $student->feeAssignments->sum(function ($feeAssignment) {
            $totalPaid = $feeAssignment->payments()->uncancelled()->sum('amount_paid');
            $adjustedFee = $feeAssignment->adjusted_fee ?? $feeAssignment->assigned_fee;
            return max(0, $adjustedFee - $totalPaid);
            
        });
        
     
        return (object)[
            'admission_number' => $student->admission_number,
            'name' => $student->name,
            'current_grade' => $student->current_grade,
            'current_class' => $student->current_class,
            'due_amount' => $dueAmount,
        ];
    });
        $studentGroups = $studentsWithDue->groupBy('current_class');
    

        $report= view('reports.duereport',compact('studentsWithDue','studentGroups','grade','class'))->render();   
          
        $pdf=Browsershot::html($report)->setChromePath('/usr/bin/chromium-browser')->noSandbox()->format('A4')->margins(5, 5, 5, 5)->pdf();
        return response()->make($pdf, 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'inline; filename="duereport.pdf"',
        ]);
       

    }
}
