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
}
