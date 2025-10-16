<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class BackupController extends Controller
{
    public function backup()
    {
       $db=env('DB_DATABASE');
       $un=env('DB_USERNAME');
       $pw=env('DB_PASSWORD');
       $host=env('DB_HOST');
       $port=env('DB_PORT');
       $date=now()->format('Y-m-d_H-i-s');
        $passwordPart = $pw ? "-p{$pw}" : "";
        $mysqldumpPath = "\"C:\\xampp\\mysql\\bin\\mysqldump.exe\"";
       $filename="backup_{$db}_{$date}.sql";
       $path=public_path($filename);
       $cmd="{$mysqldumpPath} -u {$un} {$passwordPart} -h {$host} -P {$port} {$db} > \"{$path}\"";
       exec($cmd, $output, $returnVar);

       if($returnVar !== 0 || !file_exists($path)|| filesize($path)==0){ {
            return response()->json([
                'error' => 'Backup failed',
                'output'=> $output,
                'code'=>$returnVar,
                'cmd'=>$cmd
                ],500);
           //return redirect()->back()->with('error', 'Backup failed');
       }
       return response()->download(public_path($path));
    }
}   
}
