import React, { Component } from 'react';
import { Table, Button } from 'react-bootstrap';
import { TitlePage } from '../components/TitlePage';
import { Link } from 'react-router-dom';
import { readStock,removeStock } from '../services/api';
import {Loading} from '../components/Loading';

export class StockIndex extends Component {
  constructor(props){
    super(props)
    this.state = {
      stock: [],
      ready:false
    }
    this._isMounted = false;
  }
  
//Cargamos los datos del stock
  async componentDidMount() {
      const data = await readStock();
     this.setState({ stock: data,ready:true })
 
  }

  //Borramos el Stock
   handleClickDelete =async (stock) => {
    try {
      await removeStock(stock.id);
   } catch (error) {
      console.log(error)
    }
    //evitamos hacer otra peticion a la api (read) lo borramos del state
    this.setState({stock: this.state.stock.filter(item => item !== stock)});

  }

  render() {

    return (
      <>
        <TitlePage>Stock ABM</TitlePage>

        <Link to='/add'>
          <Button variant="primary" className="mt-5 mb-3">Agregar Stock</Button>
        </Link>

      {!this.state.ready ?  <Loading/>
   :
        <Table striped bordered hover variant="dark" responsive>
          <thead>
            <tr>
              <th>Id Stock</th>
              <th>Producto</th>
              <th>Precio Producto</th>
              <th>Cliente</th>
              <th>Opciones</th>
            </tr>
          </thead>

          <tbody>
            {this.state.stock.map((i, index) => (
              <tr key={index}>
                <td>{i.id}</td>
            <td>{i.producto.nombre}</td>
            <td>${i.producto.precio}</td>

                <td>{i.cliente.nombre} {i.cliente.apellido}</td>
                <td>
                <Link to={`/edit/${i.id}`}>  <Button variant="success">Editar</Button>{' '}</Link>
                  <Button variant="danger" onClick={()=>this.handleClickDelete(i)}>Borrar</Button>
                </td>
              </tr>
            ))}
          </tbody>
        </Table>
  }
      </>
    )
  }
}
