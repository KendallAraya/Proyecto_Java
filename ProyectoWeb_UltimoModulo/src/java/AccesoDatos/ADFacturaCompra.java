
package AccesoDatos;

import Entidades.Compra;
import java.sql.*;
import java.util.*;

//importar los metodos de la ClaseConesion
import static AccesoDatos.ClaseConexion.getcConnection;
import Entidades.MostrarDetalles;
import Entidades.MostrarFacturas;
import Entidades.Producto;

public class ADFacturaCompra {
    //Atributos
    private String _mensaje;
    
    //Propiedades
    public String getMensaje(){
        return _mensaje;
    }
    //constructor
    public ADFacturaCompra(){
        _mensaje="";
    }
    

//    Insertar una Compra
    public int InsertarCompra(Compra compra) throws Exception {
        int resultado = -1;
        CallableStatement cs = null;
        Connection _conexion = null;

        try {
            _conexion = getcConnection();
            cs = _conexion.prepareCall("{call sp_CrearFacturaCompraWeb(?, ?, ?, ?)}");
            cs.setInt(1, compra.getIdFuncionario());
            cs.setInt(2, compra.getIdProveedor());
            cs.setString(3, compra.getMetodoPago());
            cs.registerOutParameter(4, Types.INTEGER);

            resultado = cs.executeUpdate();

            compra.setIdCompra(cs.getInt(4));

        } catch (Exception ex) {
            _mensaje = "Error inesperado, intentar más tarde";
            throw ex;
        } finally {
            if (_conexion != null) {
                ClaseConexion.close(_conexion);
            }
        }
        return resultado;
    }//fin InsertarCompra
    
    
    public int InsertarProductoDetalle(Producto producto, int IdFact)throws Exception {
        int resultado = -1;
        CallableStatement cs = null;
        Connection _conexion = null;

        try {
            _conexion = getcConnection();
            cs = _conexion.prepareCall("{call sp_CrearProductoYAgregarDetalle(?, ?, ?, ?, ?, ?, ?)}");
            cs.setString(1, producto.getDescripcion());
            cs.setDate(2, producto.getCaducidad());
            cs.setString(3, producto.getCategoria());
            cs.setFloat(4, producto.getPrecio());
            cs.setFloat(5, producto.getCantidad());
            cs.setInt(6, IdFact);
            cs.registerOutParameter(7, Types.VARCHAR);

            resultado = cs.executeUpdate();
            
            _mensaje = cs.getString(7);


        } catch (Exception ex) {
            _mensaje = "Error inesperado, intentar más tarde";
            throw ex;
        } finally {
            if (_conexion != null) {
                ClaseConexion.close(_conexion);
            }
        }
        return resultado;
    }
    
    public int ObtenerUltimoId()throws Exception {
        int ultimoIdCompra = -1;
        CallableStatement cs = null;
        Connection _conexion = null;

        try {
            _conexion = getcConnection();
            cs = _conexion.prepareCall("{call ObtenerIdConUltimaCompra(?)}");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.execute();

            // Obtener el valor del parámetro de salida
            ultimoIdCompra = cs.getInt(1);


        } catch (Exception ex) {
            _mensaje = "Error inesperado, intentar más tarde";
            throw ex;
        } finally {
            if (_conexion != null) {
                ClaseConexion.close(_conexion);
            }
        }
        return ultimoIdCompra;
    }
    
    public List<MostrarDetalles> ListarDetallesCompras_List(int idFactura) throws Exception{
        ResultSet rs=null;
        MostrarDetalles Detalle;
        List<MostrarDetalles> lista = new ArrayList();
        Connection _conexion=null;
        try {
            // Abrir la conexión
            _conexion = ClaseConexion.getcConnection();
            Statement stm = _conexion.createStatement();

            String sentencia = "SELECT DC.IdDetalleCompra, " +
                "P.Descripcion AS DescripcionProducto, " +
                "P.Caducidad AS CaducidadProducto, " +
                "P.Categoria AS CategoriaProducto, " +
                "P.Precio AS PrecioProducto, " +
                "P.Cantidad AS CantidadProducto, " +
                "P.Estado AS EstadoProducto, " +
                "P.FechaIngreso AS FechaIngresoProducto, " +
                "SUM(P.Precio * P.Cantidad) AS TotalDetalle " + // Agregar el cálculo del total
                "FROM DetalleCompra AS DC " +
                "INNER JOIN Productos AS P ON DC.IdProducto = P.IdProducto " +
                "WHERE DC.IdCompra = " + idFactura + " "; // Agregar filtro por ID de factura

            sentencia += "GROUP BY DC.IdDetalleCompra, " +
                "P.Descripcion, " +
                "P.Caducidad, " +
                "P.Categoria, " +
                "P.Precio, " +
                "P.Cantidad, " +
                "P.Estado, " +
                "P.FechaIngreso";

            rs = stm.executeQuery(sentencia);
            while (rs.next()) {
                Detalle = new MostrarDetalles(
                    rs.getInt("IdDetalleCompra"),
                    rs.getString("DescripcionProducto"),
                    rs.getDate("CaducidadProducto"),
                    rs.getString("CategoriaProducto"),
                    rs.getFloat("PrecioProducto"),
                    rs.getFloat("CantidadProducto"),
                    rs.getString("EstadoProducto"),
                    rs.getDate("FechaIngresoProducto"),
                    rs.getFloat("TotalDetalle")
                );

                lista.add(Detalle);
            }
        } catch (Exception ex) {throw ex;}
        finally{
            if(!_conexion.equals(null)){
                ClaseConexion.close(_conexion);
            }
        }
        return lista;
    }
    
    public float ObtenerTotalDineroDetallesCompra(int idCompra) throws SQLException, Exception {
        float totalDinero = 0;
        Connection _conexion = null;
        ResultSet rs = null;

        try {
            _conexion = ClaseConexion.getcConnection();
            Statement stm = _conexion.createStatement();

            String query = "SELECT (SUM(p.Precio * p.Cantidad) * 1.13) AS TotalDineroConImpuesto " +
                           "FROM DetalleCompra dc " +
                           "INNER JOIN Productos p ON dc.IdProducto = p.IdProducto " +
                           "WHERE dc.IdCompra = " + idCompra;

            rs = stm.executeQuery(query);

            if (rs.next()) {
                totalDinero = rs.getFloat("TotalDineroConImpuesto");
            }

        } catch (Exception ex) {throw ex;}
        finally{
            if(!_conexion.equals(null)){
                ClaseConexion.close(_conexion);
            }
        }

        return totalDinero;
    }


    public int EliminarDetalle(int id)throws Exception {
        int resultado = -1;
        CallableStatement cs = null;
        Connection _conexion = null;

        try {
            _conexion = getcConnection();
            cs = _conexion.prepareCall("{call sp_EliminarDetalleCompraConProducto(?, ?)}");
            cs.setInt(1, id);
            cs.registerOutParameter(2, Types.VARCHAR);

            resultado = cs.executeUpdate();

            // Obtener el valor del parámetro de salida
            _mensaje = cs.getString(2);


        } catch (Exception ex) {
            _mensaje = "Error inesperado, intentar más tarde";
            throw ex;
        } finally {
            if (_conexion != null) {
                ClaseConexion.close(_conexion);
            }
        }
        return resultado;
    }
    
    public List<MostrarFacturas> ListarFacturasCompras() throws Exception {
        ResultSet rs = null;
        MostrarFacturas factura;
        List<MostrarFacturas> lista = new ArrayList<>();
        Connection conexion = null;
        try {
            // Abrir la conexión
            conexion = ClaseConexion.getcConnection();
            Statement stm = conexion.createStatement();

            String sentencia = "SELECT C.IdCompra, " +
                "F.NombreCompleto AS Funcionario, " +
                "P.Nombre AS Proveedor, " +
                "C.PrecioTotal, " +
                "C.Fecha, " +
                "C.MetodoPago, " +
                "PR.Descripcion AS Producto, " +
                "PR.Precio AS PrecioProducto " +
                "FROM Compra C " +
                "INNER JOIN Funcionario F ON C.IdFuncionario = F.IdFuncionario " +
                "INNER JOIN Proveedores P ON C.IdProveedor = P.IdProveedor " +
                "INNER JOIN DetalleCompra DC ON C.IdCompra = DC.IdCompra " +
                "INNER JOIN Productos PR ON DC.IdProducto = PR.IdProducto ";

            rs = stm.executeQuery(sentencia);
            while (rs.next()) {
                factura = new MostrarFacturas(
                    rs.getInt("IdCompra"),
                    rs.getString("Funcionario"),
                    rs.getString("Proveedor"),
                    rs.getFloat("PrecioTotal"),
                    rs.getDate("Fecha"),
                    rs.getString("MetodoPago"),
                    rs.getString("Producto"),
                    rs.getFloat("PrecioProducto")
                );

                lista.add(factura);
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (conexion != null) {
                ClaseConexion.close(conexion);
            }
        }
        return lista;
    }
}
