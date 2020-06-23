import React, { Component } from 'react';
import { Form } from 'react-bootstrap';
import { readProductos } from '../services/api';

export class SelectDataProducto extends Component {

    constructor(props) {
        super(props)
        this.state = {
            productos: [],
        }
    }

    async componentDidMount() {
        try {
            const dataProductos=await readProductos();
            this.setState({ 
                productos:dataProductos
            })
        
        } catch (error) {
            console.log(error)
        }
    }
    
    handldeChange=(e)=>{
          this.props.onResults("producto",parseInt(e.target.value))
   }
      
render(){
    return(
   <div className="col-md-6">
                        <Form.Group controlId="exampleForm.ControlSelect1">


                            <Form.Label>Producto</Form.Label>
                            <Form.Control as="select" name="producto_id_selected" onChange={this.handldeChange}>
                            <option value="0">Selecionar Producto</option>

                                {this.state.productos.map((i, index) => (
                                    <option key={index} value={i.codigo}>{i.codigo}-{i.nombre}</option>
                                ))}
                            </Form.Control>
                        </Form.Group>
                    </div>

    )
}
  }
