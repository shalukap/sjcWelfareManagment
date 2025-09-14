<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
      use HasFactory;

    protected $fillable = [
        'admission_number',
        'name',
        'whatsapp_number',
        'current_grade',
        'current_class',
        'is_active',
    ];

  
    protected $casts = [
        'is_active' => 'boolean',
    ];
}
