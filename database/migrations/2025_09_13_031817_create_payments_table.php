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
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('fee_assignment_id')->constrained()->onDelete('cascade');
            $table->string('receipt_number')->unique();
            $table->date('payment_date');
            $table->decimal('amount_paid', 10, 2);
            $table->enum('payment_method', ['Cash', 'Online', 'Cheque']);
            $table->string('reference_number')->nullable(); // For Online & Cheque
            $table->date('deposit_date')->nullable(); // For Online & Cheque
            $table->string('bank_name')->nullable(); // For Cheque
            $table->boolean('is_realized')->default(false); // For Cheque
            $table->boolean('cancelled')->default(false);
            $table->dateTime('cancellation_date')->nullable();
            $table->foreignId('cancelled_by_user_id')->nullable()->constrained('users')->onDelete('set null');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
