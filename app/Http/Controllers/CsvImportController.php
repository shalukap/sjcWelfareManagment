<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;


class CsvImportController extends Controller
{
    public function index()
    {
        return Inertia::render('UploadCsv/Index');
    }

    public function upload(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:csv,txt'
        ]);

        $path = $request->file('file')->getRealPath();
        $file=fopen($path,"r");

        $header= fgetcsv($file);
        if (!$header){
            return responce()->json([
                'error' => 'invalid file format'
            ],400);
        }
        $rows=[];
        while($row=fgetcsv($file)){
            $rows[]=array_combine($header,$row);
           
        }
        fclose($file);

        foreach ($rows as $row) {
            DB::table('students')->insert($row);
        }
        return redirect()->route('csv.upload')->with('success', 'CSV file uploaded successfully.');
    }
}
