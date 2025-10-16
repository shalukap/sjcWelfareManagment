<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\StudentController;
use App\Http\Controllers\FeeAssignmentController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\CollectionReportController;
use App\Http\Controllers\DueReportsController;
use App\Http\Controllers\DashboardController;


Route::get('/', function () {
    return Inertia::render('welcome');
})->name('home');

// Temporary diagnostic route (plain text) to verify the upgrade URL is reachable
Route::get('students/upgrade-debug', function () {
    return response('upgrade route reachable', 200)
        ->header('Content-Type', 'text/plain');
});

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('dashboard', [DashboardController::class, 'index'])->name('dashboard');



    // Students upgrade routes (placed before resource to avoid conflicts)
    Route::get('students/upgrade', [StudentController::class, 'showUpgradeForm'])->name('students.upgrade.form');
    Route::post('students/upgrade', [StudentController::class, 'upgrade'])->name('students.upgrade');

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
