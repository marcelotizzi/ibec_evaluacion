import React, { Component } from 'react';
import { Form,Button } from 'react-bootstrap';
import { getDataStockById,updateStock,validationDataAdd} from '../services/api';
import {SelectDataCliente} from '../components/SelectDataCliente';
import {SelectDataProducto} from '../components/SelectDataProducto';
import {TitlePage} from '../components/TitlePage';
import {ButtonBack} from '../components/ButtonBack';
import {Loading} from '../components/Loading';
import {Mensaje} from '../components/Mensaje';

export class StockEdit extends Component {

    constructor(props) {
        super(props)
        this.state = {
            dataStockProducto: [],
            dataStockCliente: [],
            producto_id_selected: 0,
            cliente_id_selected: 0,
            mensaje: "",
            ready:false
        }
        //console.log(props.match.params.id) //id del stock en la URL
    }

     componentDidMount() {
    this._fetchDataActual();
    }
    async _fetchDataActual(){
        try {
            const dataActualStock = await getDataStockById(this.props.match.params.id);
         
            this.setState({ 
                dataStockProducto: dataActualStock.producto,
                dataStockCliente: dataActualStock.cliente,
                ready:true
            })
        
        } catch (error) {
            console.log(error)
        }
    }

    _handleResults=(tipo,data)=>{
        if(tipo==="producto"){
            this.setState({ producto_id_selected: data })
        }else if(tipo==="cliente"){
            this.setState({ cliente_id_selected: data })
        }
    }

    handleSubmit = async (e)=>{
        e.preventDefault();
        let data={
            'id':parseInt(this.props.match.params.id),
            'codigo_producto':this.state.producto_id_selected,
            'id_cliente':this.state.cliente_id_selected
        }

        if(!validationDataAdd(data)){
            this.setState({mensaje:"Error al Actualizar datos"})
        }else{
            const response=await updateStock(data);
              this.setState({mensaje:response})
              this._fetchDataActual();
        }
   
    }

    render() {

        return (
            <>
            <TitlePage>Ediar el Stock</TitlePage>

            <Form className="col-md-5" onSubmit={this.handleSubmit}>
                <Form.Group controlId="exampleForm.ControlInput1">
                    <Form.Label>Stock id</Form.Label>
                    <Form.Control type="number" placeholder="stock id" value={this.props.match.params.id} readOnly />
                    <hr />
                </Form.Group>

                <div className="row">
                {!this.state.ready ?  <div className="col-md-12"><Loading/></div>
                :
                    <>
                    <div className="col-md-12">
                        <center><h5><b>Datos Actuales</b></h5></center>
                      <br/>
                    </div>
                    <div className="col-md-6">

                    <b>  Codigo: </b>{this.state.dataStockProducto.codigo}<br />
                    <b>  Producto: </b>{this.state.dataStockProducto.nombre}<br />
                    <b>   Descripcion: </b>{this.state.dataStockProducto.descripcion}<br />
                    <b>     Precio:</b> $ {this.state.dataStockProducto.precio}<br />
                    </div>

                    <div className="col-md-6">

                    <b>Id: </b> {this.state.dataStockCliente.id}<br />
                    <b>Nombre: </b> {this.state.dataStockCliente.nombre}<br />
                    <b>Apellido: </b> {this.state.dataStockCliente.apellido}<br />
                    </div>
                    </>
                   } 
                    <div className="col-md-12">
                        <hr />
                    </div>
                    <SelectDataProducto onResults={this._handleResults}/>

                    <SelectDataCliente onResults={this._handleResults}/>
    
                </div>
                <Button variant="primary" className="mt-3 mb-3" size="md" block type="primary">Editar</Button>
                <br />
                    <Mensaje text={this.state.mensaje}/>
            </Form>

      <ButtonBack/>

</>
        )
    }
}