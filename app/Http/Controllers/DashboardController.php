<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Student;
use App\Models\Payment;

use Carbon\Carbon;

class DashboardController extends Controller
{
    public function index(){
        $studentsCount=Student::count();   
        $today = Carbon::today();
        $cashToday=Payment::whereDate('created_at', $today)->where('payment_method','cash')->sum('amount_paid');
        $chequeToday=Payment::whereDate('created_at', $today)->where('payment_method','cheque')->sum('amount_paid');
        $onlineToday=Payment::whereDate('created_at', $today)->where('payment_method','online')->sum('amount_paid');
    
        return Inertia::render('dashboard',
        [
            'studentsCount'=>$studentsCount,
            'cashToday'=>$cashToday,
            'chequeToday'=>$chequeToday,
            'onlineToday'=>$onlineToday
        ]);
        
    }
    
}
