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
        Schema::table('payments', function (Blueprint $table) {

            if (Schema::hasColumn('payments', 'receipt_number')) {

                try {
                    $table->dropUnique('payments_receipt_number_unique');
                } catch (\Exception $e) {

                }

                try {
                    $table->index('receipt_number', 'payments_receipt_number_index');
                } catch (\Exception $e) {
                }
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('payments', function (Blueprint $table) {
            if (Schema::hasColumn('payments', 'receipt_number')) {
                try {
                    $table->dropIndex('payments_receipt_number_index');
                } catch (\Exception $e) {
                }

                try {
                    $table->unique('receipt_number', 'payments_receipt_number_unique');
                } catch (\Exception $e) {
                }
            }
        });
    }
};
