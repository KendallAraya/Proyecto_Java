
package AccesoDatos;

import Entidades.Funcionario;
import java.sql.*;
import java.util.*;

//importar los metodos de la ClaseConesion
import static AccesoDatos.ClaseConexion.getcConnection;

public class ADFuncionarios {
    //Atributos
    private String _mensaje;
    
    //Propiedades
    public String getMensaje(){
        return _mensaje;
    }
    //constructor
    public ADFuncionarios(){
        _mensaje="";
    }
    
    //listar Clientes
    public List<Funcionario> ListarFuncionarios_List(String condicion) throws Exception{
        ResultSet rs=null;
        Funcionario funcionario;
        List<Funcionario> lista = new ArrayList();
        Connection _conexion=null;
        try {
            //abrir la coneccion
            _conexion=ClaseConexion.getcConnection();
            Statement stm = _conexion.createStatement();
            String sentencia = "SELECT IdFuncionario, Ocupacion, Cedula, NombreCompleto, Edad, Telefono, Direccion, Correo FROM Funcionario";
            if(!condicion.equals("")){
                sentencia = String.format("%s where %s" , sentencia, condicion);
            }
            rs=stm.executeQuery(sentencia);
            while(rs.next()){
                funcionario = new Funcionario(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getInt(5), rs.getString(6),rs.getString(7),rs.getString(8));
                lista.add(funcionario);
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
    public int InsertarFuncionario(Funcionario cliente) throws Exception{
        int resultado = -1;
        CallableStatement cs = null;
        Connection _conexion =null;
        try {
            _conexion = getcConnection();
            cs = _conexion.prepareCall("{call sp_InsertarFuncionario(?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            cs.setInt(1, cliente.getIdFuncionario());
            cs.setString(2, cliente.getOcupacion());
            cs.setString(3, cliente.getCedula());
            cs.setString(4, cliente.getNombreCompleto());
            cs.setInt(5, cliente.getEdad());
            cs.setString(6, cliente.getTelefono());
            cs.setString(7, cliente.getDireccion());
            cs.setString(8, cliente.getCorreo());
            cs.registerOutParameter(9, Types.VARCHAR);
            
            
            resultado = cs.executeUpdate();
            
            _mensaje = cs.getString(9);
            
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
    public Funcionario ObtenerFuncionario(String condicion)throws Exception {
        ResultSet rs = null;
        Funcionario cliente = new Funcionario();
        String Sentecia;
        Connection _conexion =null;
        
        try {
            _conexion = getcConnection();
            Statement stm = _conexion.createStatement();
            String sentencia = "SELECT IdFuncionario, Ocupacion, Cedula, NombreCompleto, Edad, Telefono, Direccion, Correo FROM Funcionario";
            if(!condicion.equals("")){
                sentencia = String.format("%s where %s", sentencia, condicion);
            }
            
            rs = stm.executeQuery(sentencia);
            if (rs.next()) {
                cliente.setIdFuncionario(rs.getInt(1));
                cliente.setOcupacion(rs.getString(2));
                cliente.setCedula(rs.getString(3));
                cliente.setNombreCompleto(rs.getString(4));
                cliente.setEdad(rs.getInt(5));
                cliente.setTelefono(rs.getString(6));
                cliente.setDireccion(rs.getString(7));
                cliente.setCorreo(rs.getString(8));
            }
            
        } catch (Exception e) {throw e;}
        finally{
            if(_conexion !=null){
                    ClaseConexion.close(_conexion);
                } 
        }
        
        return cliente;
    }
    
    public int EliminarFuncionario(Funcionario cliente) throws Exception{
        CallableStatement CS = null;
        
        int resultado = -1;
        
        Connection _conexion = null;
        
        try {
            _conexion = ClaseConexion.getcConnection();
            //Registrar los parametros
            CS = _conexion.prepareCall("{call spEliminarFuncionarioConValidacion(?,?)}");
            CS.setInt(1, cliente.getIdFuncionario());
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
