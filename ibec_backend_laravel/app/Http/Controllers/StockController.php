<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
Use Exception;

use App\Stock;

class StockController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Stock::All();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        try {
            Stock::create([
                'id'=>$request->id,
                'codigo_producto'=>$request->codigo_producto,
                'id_cliente'=>$request->id_cliente
                ]);
                return json_encode("Ingresado con Exito");

            }catch(Exception $e){
                return json_encode("Error al Ingresar datos, ya existentes");
        }

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
       return $this->dataStockById($id);

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
       return  $this->dataStockById($id);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $stock = Stock::find($id);
        $stock->codigo_producto = $request->codigo_producto;
        $stock->id_cliente = $request->id_cliente;
        $stock->save();
        return json_encode("Actualizado con Exito");

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $stock = Stock::find($id);
        $stock->delete();
    }

    public function dataStockById($id){
        $stock=Stock::find($id);
        //les sacamos las fk para respetar el estandar de la letra.
        unset($stock["codigo_producto"]);
        unset($stock["id_cliente"]);
        return $stock;
    }
}
