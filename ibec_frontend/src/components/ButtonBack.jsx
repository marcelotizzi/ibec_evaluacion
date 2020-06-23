import  React from 'react';
import {Link} from 'react-router-dom';
import {Button} from 'react-bootstrap';

export const ButtonBack =()=> (

            <Link to="/">
                    <Button variant="secondary" className="mt-3 mb-3" size="md" block>Volver</Button>
            </Link>
  
)
