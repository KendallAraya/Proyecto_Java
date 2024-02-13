
package AccesoDatos;
import Entidades.Producto;
import java.sql.*;
import java.util.*;

//importar los metodos de la ClaseConesion
import static AccesoDatos.ClaseConexion.getcConnection;

public class ADProducto {
    //Atributos
    private String _mensaje;
    
    //Propiedades
    public String getMensaje(){
        return _mensaje;
    }
    //constructor
    public ADProducto(){
        _mensaje="";
    }
    
    public List<Producto> ListarProducto_List(String condicion) throws Exception {
        ResultSet rs = null;
        Producto producto;
        List<Producto> lista = new ArrayList();
        Connection _conexion = null;

        try {
            // Abrir la conexión
            _conexion = ClaseConexion.getcConnection();
            Statement stm = _conexion.createStatement();
            String sentencia = "SELECT IdProducto, Descripcion, Caducidad, Categoria, Precio, Cantidad, Estado, FechaIngreso FROM Productos";

            if (!condicion.equals("")) {
                sentencia = String.format("%s WHERE %s", sentencia, condicion);
            }

            rs = stm.executeQuery(sentencia);

            while (rs.next()) {
                producto = new Producto(
                    rs.getInt("IdProducto"),
                    rs.getString("Descripcion"),
                    rs.getDate("Caducidad"),
                    rs.getString("Categoria"),
                    rs.getFloat("Precio"),
                    rs.getFloat("Cantidad"),
                    rs.getString("Estado"),
                    rs.getDate("FechaIngreso")
                );

                lista.add(producto);
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
