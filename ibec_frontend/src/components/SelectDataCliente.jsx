import React, { Component } from 'react';
import { Form } from 'react-bootstrap';
import { readClientes } from '../services/api';

export class SelectDataCliente extends Component {

    constructor(props) {
        super(props)
        this.state = {
            clientes: [],
        }
    }

    async componentDidMount() {
        try {
            const dataClientes=await readClientes();
            this.setState({ 
                clientes:dataClientes
            })
        
        } catch (error) {
            console.log(error)
        }
    }
    
    handldeChange=(e)=>{
        this.props.onResults("cliente",parseInt(e.target.value))
   }

    render() {
        return (

            <div className="col-md-6">
                <Form.Group controlId="exampleForm.ControlSelect1">
                    <Form.Label>Cliente</Form.Label>
                    <Form.Control as="select" name="producto_id_selected" onChange={this.handldeChange}>
                        <option value="0">Selecionar Cliente</option>

                        {this.state.clientes.map((i, index) => (
                            <option key={index} value={i.id}>{i.id}-{i.nombre} {i.apellido}</option>
                        ))}
                    </Form.Control>
                </Form.Group>
            </div>

        )
    }
}
