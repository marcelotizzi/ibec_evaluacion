<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    protected $table = 'clientes';
    protected $primaryKey = 'id';
    public $incrementing = true;
    public $timestamps = true;
    protected $fillable = [
        'id',
        'nombre',
        'apellido'
    ];

 /*   public function Stock(){
        return $this->hasMany('App\Stock');
    }
*/
}
