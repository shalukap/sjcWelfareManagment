<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\StudentController;
use App\Http\Controllers\FeeAssignmentController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\CollectionReportController;
use App\Http\Controllers\DueReportsController;


Route::get('/', function () {
    return Inertia::render('welcome');
})->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('dashboard', function () {
        return Inertia::render('dashboard');
    })->name('dashboard');


    Route::resource('students', StudentController::class);

    Route::resource('payments', PaymentController::class)->except(['destroy']);
    Route::delete('payments/{id}', [PaymentController::class, 'destroy'])->name('payments.destroy');
    Route::post('payments/{id}/cancel', [PaymentController::class, 'cancel'])->name('payments.cancel');
    Route::get('payments/search/students', [PaymentController::class, 'searchStudents'])->name('payments.search.students');
    Route::get('payments/students/{studentId}/assignments', [PaymentController::class, 'getStudentAssignments'])->name('payments.students.assignments');
    Route::get('payments/search/student-assignments', [PaymentController::class, 'searchStudentAssignments'])->name('payments.search.student.assignments');
    Route::get('reports/collectionreport', [CollectionReportController::class, 'index'])->name('report.collectionreport');
    Route::get('reports/duereport', [DueReportsController::class, 'index'])->name('duereport');
    Route::get('generate-duereport', [DueReportsController::class, 'generateDueReport'])->name('generateDueReport');
    Route::get('generate-recipt',[PaymentController::class,'generatePDF'])->name('generate-recipt');
    Route::get('generate-collection',[CollectionReportController::class,'generatecollectionreport'])->name('generatecollectionreport');
    Route::prefix('fee-assignments')->group(function () {

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
