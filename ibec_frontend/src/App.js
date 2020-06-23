import React from 'react';
import {Switch,Route} from "react-router-dom";
import {StockIndex} from './pages/StockIndex';
import {StockAdd} from './pages/StockAdd';
import {StockEdit} from './pages/StockEdit';

import './App.css';

function App() {
  console.log(React.version)
  return (
    <div className="container">
  <header className="App-header">
    <Switch>

      <Route exact path='/' component={StockIndex}/>
      <Route exact path='/add' component={StockAdd}/>
      <Route exact path='/edit/:id' component={StockEdit}/>    
  </Switch>
  </header>
  </div>
  );
}

export default App;
