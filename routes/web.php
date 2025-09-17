<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\StudentController;
use App\Http\Controllers\FeeAssignmentController;

Route::get('/', function () {
    return Inertia::render('welcome');
})->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('dashboard', function () {
        return Inertia::render('dashboard');
    })->name('dashboard');


    Route::resource('students', StudentController::class);


    Route::prefix('fee-assignments')->group(function () {

        Route::get('/search', [FeeAssignmentController::class, 'searchStudent'])->name('fee-assignments.search');
        Route::post('/get-student-assignments', [FeeAssignmentController::class, 'getStudentAssignments'])->name('fee-assignments.get-student-assignments');
        Route::get('/create-grade', [FeeAssignmentController::class, 'createGrade'])->name('fee-assignments.create-grade');
        Route::post('/store-grade', [FeeAssignmentController::class, 'storeGrade'])->name('fee-assignments.store-grade');

        Route::resource('/', FeeAssignmentController::class)
            ->parameter('', 'fee_assignment')
            ->except(['create', 'store'])
            ->names('fee-assignments');
    });

});


require __DIR__.'/settings.php';
require __DIR__.'/auth.php';
