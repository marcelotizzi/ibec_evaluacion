const baseUrl="http://localhost:8000/api";
const controller = new AbortController()
const signal = controller.signal

async function request(url, method,data){
    const response = await fetch(`${baseUrl}${url}`,{
        method,
        signal,
        headers:{
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: data ? data : undefined,
    })
    const jsonResponse= await response.json();

    if(!response.status===200){
        console.log("Error en la peticion "+response.status)
    }
 
    return jsonResponse;
}

//Read Stock
export function readStock(){
    return request('/stock','GET')
}
//Add Stock
export function addStock(data){
    return request('/stock','POST',fromBody(data))
}
//Remove Stock
export function removeStock(id){
  return request( `/stock/${id}`,'DELETE')
}
//get data Stock by Id
export function getDataStockById(id){
    return request(`/stock/${id}/edit`,'GET')
}
//Update Stock
export function updateStock(data){
    return request(`/stock/${data.id}`,'PUT',fromBody(data))
}
//Read Clientes
export function readClientes(){
    return request(`/clientes`,'GET')
}
//Read Productos
export function  readProductos(){
    return request(`/productos`,'GET')
}

//Valido datos antes de enviar
export function validationDataAdd(data){
    if(data.id===0 || data.codigo_producto===0 || data.id_cliente===0){
        return false;
    } else{
        return true;
    }
}


function fromBody(data){
 //x-www-form-urlencoded
    var formBody = [];
    for (var property in data) {
      var encodedKey = encodeURIComponent(property);
      var encodedValue = encodeURIComponent(data[property]);
      formBody.push(encodedKey + "=" + encodedValue);
    }
   return formBody = formBody.join("&");
}