<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Stock extends Model
{
    protected $table = 'stock';
    protected $primaryKey = 'id';
    public $incrementing = false;
    public $timestamps = false;
    protected $fillable = [
        'id',
        'codigo_producto',
        'id_cliente'
    ];
    protected $with = ['producto','cliente'];

    public function producto(){
        return $this->belongsTo('App\Producto','codigo_producto', 'codigo');
    }
    public function cliente(){
        return $this->belongsTo('App\Cliente','id_cliente', 'id');
    }
}
