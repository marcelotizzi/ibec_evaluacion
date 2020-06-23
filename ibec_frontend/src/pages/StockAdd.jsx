import React, { Component } from 'react';
import { TitlePage } from '../components/TitlePage';
import { Form, Button } from 'react-bootstrap';
import { readClientes, readProductos, addStock,validationDataAdd } from '../services/api';
import { ButtonBack } from '../components/ButtonBack';
import {SelectDataCliente} from '../components/SelectDataCliente';
import {SelectDataProducto} from '../components/SelectDataProducto';
import {Mensaje} from '../components/Mensaje';

export class StockAdd extends Component {

  constructor(props) {
    super(props)
    this.state = {
      productos: [],
      clientes: [],
      producto_id_selected: 0,
      cliente_id_selected: 0,
      stock_id: 0,
      mensaje: ""

    }
  }

  async componentDidMount() {
    try {
      const dataClientes = await readClientes();
      const dataProductos = await readProductos();
      this.setState({ clientes: dataClientes, productos: dataProductos })
    } catch (error) {
      console.log(error)
    }
  }

  handldeChange = (e) => {
    this.setState({
      [e.target.name]: e.target.value
    })
  }

  _handleResults=(tipo,data)=>{
    if(tipo==="producto"){
        this.setState({ producto_id_selected: data })
    }else if(tipo==="cliente"){
        this.setState({ cliente_id_selected: data })
    }
}

  handleSubmit = async (e) => {
    e.preventDefault();

    let data = {
        'id': parseInt(this.state.stock_id),
        'codigo_producto': this.state.producto_id_selected,
        'id_cliente': this.state.cliente_id_selected
      }

      if (!validationDataAdd(data)) {
        this.setState({ mensaje: "Error al Ingresar Datos" })
      } else {
        const response = await addStock(data);
        this.setState({ mensaje: response })
      }

  }
  render() {
    return (
      <>
        <TitlePage>Agregar Stock</TitlePage>

        <Form className="col-md-5" onSubmit={this.handleSubmit}>
          <Form.Group controlId="exampleForm.ControlInput1">
            <Form.Label>Stock id</Form.Label>
            <Form.Control type="number" placeholder="stock id" name="stock_id" onChange={this.handldeChange} />
          </Form.Group>

          <div className="row">
         <SelectDataProducto onResults={this._handleResults}/>

           <SelectDataCliente onResults={this._handleResults}/>
    
          </div>
          <Button variant="primary" className="mt-3 mb-3" size="md" block type="submit">Añadir</Button>
      
          <Mensaje text={this.state.mensaje}/>

        </Form>
        <ButtonBack />
      </>
    )
  }
}
