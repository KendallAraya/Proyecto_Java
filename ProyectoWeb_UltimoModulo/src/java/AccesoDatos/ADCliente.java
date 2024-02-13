
package AccesoDatos;

import Entidades.Cliente;
import java.sql.*;
import java.util.*;

//importar los metodos de la ClaseConesion
import static AccesoDatos.ClaseConexion.getcConnection;

public class ADCliente {
    //Atributos
    private String _mensaje;
    
    //Propiedades
    public String getMensaje(){
        return _mensaje;
    }
    //constructor
    public ADCliente(){
        _mensaje="";
    }
    
    //listar Clientes
    public List<Cliente> ListarClientes_List(String condicion) throws Exception{
        ResultSet rs=null;
        Cliente cliente;
        List<Cliente> lista = new ArrayList();
        Connection _conexion=null;
        try {
            //abrir la coneccion
            _conexion=ClaseConexion.getcConnection();
            Statement stm = _conexion.createStatement();
            String sentencia = "SELECT IdCliente, Cedula, NombreCompleto, Edad, TELEFONO, DIRECCION, Correo FROM Cliente";
            if(!condicion.equals("")){
                sentencia = String.format("%s where %s" , sentencia, condicion);
            }
            rs=stm.executeQuery(sentencia);
            while(rs.next()){
                cliente = new Cliente(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getInt(4), rs.getString(5),rs.getString(6),rs.getString(7));
                lista.add(cliente);
            }
        } catch (Exception ex) {throw ex;}
        finally{
            if(!_conexion.equals(null)){
                ClaseConexion.close(_conexion);
            }
        }
        return lista;
    }//ListarClientes_List

//    Insertar un Cliente
    public int InsertarCliente(Cliente cliente) throws Exception{
        int resultado = -1;
        CallableStatement cs = null;
        Connection _conexion =null;
        try {
            _conexion = getcConnection();
            cs = _conexion.prepareCall("{call sp_InsertarCliente(?, ?, ?, ?, ?, ?, ?, ?)}");
            cs.setInt(1, cliente.getIdCliente());
            cs.setString(2, cliente.getCedula());
            cs.setString(3, cliente.getNombreCompleto());
            cs.setInt(4, cliente.getEdad());
            cs.setString(5, cliente.getTelefono());
            cs.setString(6, cliente.getDireccion());
            cs.setString(7, cliente.getCorreo());
            cs.registerOutParameter(8, Types.VARCHAR);
            
            
            resultado = cs.executeUpdate();
            
            _mensaje = cs.getString(8);
            
        } catch (Exception ex) {
            _mensaje = "Error inesperado, intentar mas tarde";
            throw ex;
        }
        finally{
            if(!_conexion.equals(null)){
                ClaseConexion.close(_conexion);
            }
        }
        return resultado;
    }//fin InsertarCliente
    
    
//    Obtener un Cliente
    public Cliente ObtenerCliente(String condicion)throws Exception {
        ResultSet rs = null;
        Cliente cliente = new Cliente();
        String Sentecia;
        Connection _conexion =null;
        
        try {
            _conexion = getcConnection();
            Statement stm = _conexion.createStatement();
            String sentencia = "SELECT IdCliente, Cedula, NombreCompleto, Edad, TELEFONO, DIRECCION, Correo FROM Cliente";
            if(!condicion.equals("")){
                sentencia = String.format("%s where %s", sentencia, condicion);
            }
            
            rs = stm.executeQuery(sentencia);
            if (rs.next()) {
                cliente.setIdCliente(rs.getInt(1));
                cliente.setCedula(rs.getString(2));
                cliente.setNombreCompleto(rs.getString(3));
                cliente.setEdad(rs.getInt(4));
                cliente.setTelefono(rs.getString(5));
                cliente.setDireccion(rs.getString(6));
                cliente.setCorreo(rs.getString(7));
            }
            
        } catch (Exception e) {throw e;}
        finally{
            if(_conexion !=null){
                    ClaseConexion.close(_conexion);
                } 
        }
        
        return cliente;
    }
    
    //EliminarCliente Cliente
    public int EliminarCliente(Cliente cliente) throws Exception{
        CallableStatement CS = null;
        
        int resultado = -1;
        
        Connection _conexion = null;
        
        try {
            _conexion = ClaseConexion.getcConnection();
            //Registrar los parametros
            CS = _conexion.prepareCall("{call spEliminarClienteConValidacion(?,?)}");
            CS.setInt(1, cliente.getIdCliente());
            CS.setString(2, _mensaje);
            //Parametros de salida
            CS.registerOutParameter(2, Types.VARCHAR);
            //Ejecutar sentencia
            resultado = CS.executeUpdate();
            //leer parametro de salida
            _mensaje = CS.getString(2);
            
        } catch (Exception ex) {}
        finally{
            if(_conexion !=null){
                ClaseConexion.close(_conexion);
            }
        }
        return resultado;
    }
}
