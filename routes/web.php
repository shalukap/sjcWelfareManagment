<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\StudentController;

Route::get('/', function () {
    return Inertia::render('welcome');
})->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('dashboard', function () {
        return Inertia::render('dashboard');
    })->name('dashboard');

    Route::resource('students', StudentController::class);

});

// Add this to routes/web.php temporarily
Route::get('/debug-routes', function () {
    $routes = [
        'students.index' => route('students.index'),
        'students.create' => route('students.create'),
        'students.edit' => route('students.edit', 1),
        'students.destroy' => route('students.destroy', 1),
    ];

    return response()->json($routes);
});

require __DIR__.'/settings.php';
require __DIR__.'/auth.php';
