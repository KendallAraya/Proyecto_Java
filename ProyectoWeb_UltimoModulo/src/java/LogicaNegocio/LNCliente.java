package LogicaNegocio;

import AccesoDatos.ADCliente;
import Entidades.Cliente;
import java.util.ArrayList;
import java.util.List;


public class LNCliente {
    //Atributos
    private String _mensaje;
    
    public String getMensaje() {
        return _mensaje;
    }
    
    public int InsertarCliente(Cliente cliente) throws Exception{
        
        int id = -1;
        ADCliente adcliente;
        try {
            adcliente = new ADCliente();
            id = adcliente.InsertarCliente(cliente);
            _mensaje = adcliente.getMensaje();
            
        } catch (Exception ex) {
            throw ex;
        }
        
        return id;
    }
    
    public List<Cliente> ListarClientes_List(String condicion) throws Exception{
        List<Cliente> resultado = new ArrayList();
        ADCliente adcliente;
        try {
            adcliente=new ADCliente();
            resultado = adcliente.ListarClientes_List(condicion);
        } catch (Exception e) {
            throw e;
        }
        return resultado;
    }
    
    public Cliente ObtenerCliente(String condicion) throws Exception{
        Cliente cliente;
        ADCliente ADcliente;
        
        try {
            ADcliente = new ADCliente();
            cliente = ADcliente.ObtenerCliente(condicion);
            if (cliente.isExiste()) {
                _mensaje = "Cliente recuperado";
            }
            else{
                _mensaje = "Cliente no existe en la BD";
            }
            
        } catch (Exception ex) {
            throw ex;
        }
        return cliente;
    }
    
//    public int ModicarCliente(Cliente cliente) throws Exception{
//        int resultado = -1;
//        ADCliente ADcliente;
//        
//        try {
//            ADcliente = new ADCliente();
//            resultado = ADcliente.ModificarCliente(cliente);
//            _mensaje = ADcliente.getMensaje();
//            
//        } catch (Exception ex) {
//            throw ex;
//        }
//        return resultado;
//    }

    public int EliminarCliente(Cliente cliente) throws Exception{
        int resultado = -1;
        ADCliente ADcliente;
        
        try {
            ADcliente = new ADCliente();
            resultado = ADcliente.EliminarCliente(cliente);
            _mensaje = ADcliente.getMensaje();
            
        } catch (Exception ex) {
            throw ex;
        }
        return resultado;
    }
}
