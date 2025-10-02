<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Add deposit_date column if missing
        if (!Schema::hasColumn('payments', 'deposit_date')) {
            Schema::table('payments', function (Blueprint $table) {
                $table->date('deposit_date')->nullable()->after('reference_number');
            });
        }

        // No enum changes here — Direct Deposit support removed per latest requirements.
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Remove deposit_date column if exists
        if (Schema::hasColumn('payments', 'deposit_date')) {
            Schema::table('payments', function (Blueprint $table) {
                $table->dropColumn('deposit_date');
            });
        }

        // Revert enum back to original values (will fail on some DBs if values exist)
        if (Schema::hasTable('payments')) {
            try {
                DB::statement("ALTER TABLE `payments` MODIFY `payment_method` ENUM('Cash','Online','Cheque') NOT NULL");
            } catch (\Exception $e) {
                // ignore
            }
        }
    }
};
