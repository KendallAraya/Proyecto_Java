package AccesoDatos;

import Entidades.Proveedor;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ADProveedor {
    //Atributos
    private String _mensaje;
    
    //Propiedades
    public String getMensaje(){
        return _mensaje;
    }
    //constructor
    public ADProveedor(){
        _mensaje="";
    }
    
    public List<Proveedor> ListarProveedor_List(String condicion) throws Exception {
        ResultSet rs = null;
        Proveedor proveedor;
        List<Proveedor> lista = new ArrayList<>();
        Connection _conexion = null;
        try {
            // Abrir la conexión
            _conexion = ClaseConexion.getcConnection();
            Statement stm = _conexion.createStatement();
            String sentencia = "SELECT IdProveedor, Nombre, NumeroContacto, Ubicacion FROM Proveedores";
            if (!condicion.equals("")) {
                sentencia = String.format("%s WHERE %s", sentencia, condicion);
            }
            rs = stm.executeQuery(sentencia);
            while (rs.next()) {
                proveedor = new Proveedor(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4)
                );
                lista.add(proveedor);
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (_conexion != null) {
                ClaseConexion.close(_conexion);
            }
        }
        return lista;
    }

}
