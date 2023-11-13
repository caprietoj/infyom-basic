<?php

namespace App\Models;

use Eloquent as Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

/**
 * Class Autor
 * @package App\Models
 * @version November 13, 2023, 11:09 pm UTC
 *
 * @property string $nombre
 * @property string $apellido
 * @property string $cargo
 */
class Autor extends Model
{
    use SoftDeletes;

    use HasFactory;

    public $table = 'autors';
    

    protected $dates = ['deleted_at'];



    public $fillable = [
        'nombre',
        'apellido',
        'cargo'
    ];

    /**
     * The attributes that should be casted to native types.
     *
     * @var array
     */
    protected $casts = [
        'nombre' => 'string',
        'apellido' => 'string',
        'cargo' => 'string'
    ];

    /**
     * Validation rules
     *
     * @var array
     */
    public static $rules = [
        
    ];

    
}
