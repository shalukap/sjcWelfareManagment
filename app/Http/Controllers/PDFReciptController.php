<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use PDF;
use App\Models\Uses;

class PDFReciptController extends Controller
{
    public function generatePDF()
    {
        $users = Uses::get();
        dd($users);
        $data = [
            'title' => "St Joseph's College Welfare Facility fee",
            'date' => date('m/d/Y'),
            'users' => $users
        ];

        $pdf = PDF::loadView('reports.recipt', $data);
        dd($pdf);
        return $pdf->download('recipt.pdf');
    }
}
