<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('students', function (Blueprint $table) {
            $table->id();//student.id
            $table->string('admission_number')->unique();
            $table->string('name');
            $table->string('whatsapp_number')->nullable();
            $table->string('current_grade'); // e.g., '10'
            $table->string('current_class')->nullable(); // e.g., 'S1'
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('student');
    }
};
