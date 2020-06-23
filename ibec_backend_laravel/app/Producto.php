<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    protected $table = 'productos';
    protected $primaryKey = 'codigo';
    public $incrementing = true;
    public $timestamps = true;
    protected $fillable = [
        'codigo',
        'nombre',
        'descripcion',
        'precio',
        'cantidad_actual'
    ];
    /*public function Stock(){
        return $this->hasMany('App\Stock');
    }*/
}
