<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class FeeAssignment extends Model
{
    use HasFactory;

    protected $fillable = [
        'student_id',
        'academic_year',
        'assigned_fee',
        'adjusted_fee',
        'adjustment_reason',
        'status',
    ];

    protected $casts = [
        'academic_year' => 'integer',
    ];

    /**
     * Get the student that owns the fee assignment.
     */
    public function student()
    {
        return $this->belongsTo(Student::class);
    }

    /**
     * Get the payments for the fee assignment.
     */
    public function payments()
    {
        return $this->hasMany(Payment::class);
    }

    /**
     * Update the status of the fee assignment based on payments.
     */
    public function updateStatus()
    {
        $totalPaid = $this->payments()->uncancelled()->sum('amount_paid');
        $adjustedFee = $this->adjusted_fee ?? $this->assigned_fee;

        if ($totalPaid >= $adjustedFee) {
            $this->status = 'Paid';
        } elseif ($totalPaid > 0) {
            $this->status = 'Partially Paid';
        } else {
            $this->status = 'Unpaid';
        }

        $this->save();
    }

    /**
     * Get the unpaid amount for this fee assignment.
     */
    public function getUnpaidAmount()
    {
        $totalPaid = $this->payments()->uncancelled()->sum('amount_paid');
        $adjustedFee = $this->adjusted_fee ?? $this->assigned_fee;
        return max(0, $adjustedFee - $totalPaid);
    }
}
