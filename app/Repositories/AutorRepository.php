<?php

namespace App\Repositories;

use App\Models\Autor;
use App\Repositories\BaseRepository;

/**
 * Class AutorRepository
 * @package App\Repositories
 * @version November 13, 2023, 11:09 pm UTC
*/

class AutorRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [
        'nombre',
        'apellido',
        'cargo'
    ];

    /**
     * Return searchable fields
     *
     * @return array
     */
    public function getFieldsSearchable()
    {
        return $this->fieldSearchable;
    }

    /**
     * Configure the Model
     **/
    public function model()
    {
        return Autor::class;
    }
}
