<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use App\Models\Payment;
use Inertia\Inertia;
use Spatie\Browsershot\Browsershot;

class CollectionReportController extends Controller
{
    public function index(){        
      
        return Inertia::render('CollectionReport/index');
    }
    public function generatecollectionreport(Request $request)
    {
        $startDate=$request->startDate;
        $endDate=$request->endDate;
       
       $payments=Payment::when($startDate, fn($q) => $q->whereDate('payment_date', '>=', $startDate))
                      ->when($endDate, fn($q) => $q->whereDate('payment_date', '<=', $endDate))->with('feeAssignment.student')->latest()->get();
       $report= view('reports.collectionreport',compact('payments'))->render(); 
       $pdf=Browsershot::html($report)->format('A4')->margins(50, 10, 5, 10)->paperSize(9.5, 5.5,'in')->pdf();     
        //$pdf=Browsershot::html($report)->setChromePath('/usr/bin/google-chrome')->noSandbox()->format('A4')->margins(5, 5, 5, 5)->pdf();
       
       return response()->make($pdf, 200, [
                'Content-Type' => 'application/pdf',
                'Content-Disposition' => 'inline; filename="collectionreport.pdf"',
            ]);
            
    }
}
