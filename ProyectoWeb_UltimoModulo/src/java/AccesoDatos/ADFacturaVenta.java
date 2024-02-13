package AccesoDatos;

import static AccesoDatos.ClaseConexion.getcConnection;
import Entidades.DetalleVenta;
import Entidades.MostrarDetalles;
import Entidades.MostrarFacturas;
import Entidades.Venta;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;


public class ADFacturaVenta {
    //Atributos
    private String _mensaje;
    
    //Propiedades
    public String getMensaje(){
        return _mensaje;
    }
    //constructor
    public ADFacturaVenta(){
        _mensaje="";
    }
    
    public int InsertarVenta(Venta venta) throws Exception {
        int resultado = -1;
        CallableStatement cs = null;
        Connection _conexion = null;

        try {
            _conexion = getcConnection();
            cs = _conexion.prepareCall("{call sp_CrearFacturaVenta(?, ?, ?, ?)}");
            cs.setInt(1, venta.getIdFuncionario());
            cs.setInt(2, venta.getIdCliente());
            cs.setString(3, venta.getMetodoPago());
            cs.registerOutParameter(4, Types.INTEGER);

            resultado = cs.executeUpdate();

            venta.setIdVenta(cs.getInt(4));

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
    
    public int InsertarDetalleVenta(DetalleVenta detalleVenta, int IdFact) throws Exception {
        int resultado = -1;
        CallableStatement cs = null;
        Connection _conexion = null;

        try {
            _conexion = getcConnection();
            cs = _conexion.prepareCall("{call sp_AgregarDetalleVenta(?, ?, ?, ?)}");
            cs.setInt(1, IdFact);
            cs.setFloat(2, detalleVenta.getCantidad());
            cs.setInt(3, detalleVenta.getIdProducto());
            cs.registerOutParameter(4, Types.VARCHAR);

            resultado = cs.executeUpdate();

            _mensaje = cs.getString(4);

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
        int ultimoIdVenta = -1;
        CallableStatement cs = null;
        Connection _conexion = null;

        try {
            _conexion = getcConnection();
            cs = _conexion.prepareCall("{call ObtenerIdConUltimaVenta(?)}");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.execute();

            // Obtener el valor del parámetro de salida
            ultimoIdVenta = cs.getInt(1);


        } catch (Exception ex) {
            _mensaje = "Error inesperado, intentar más tarde";
            throw ex;
        } finally {
            if (_conexion != null) {
                ClaseConexion.close(_conexion);
            }
        }
        return ultimoIdVenta;
    }
    
    public List<MostrarDetalles> ListarDetallesVenta_List(int idVenta) throws Exception {
        ResultSet rs = null;
        MostrarDetalles Detalle;
        List<MostrarDetalles> lista = new ArrayList<>();
        Connection _conexion = null;

        try {
            // Abrir la conexión
            _conexion = ClaseConexion.getcConnection();
            Statement stm = _conexion.createStatement();

            String sentencia = "SELECT DV.IdDetalleVenta, " +
                    "P.Descripcion AS DescripcionProducto, " +
                    "P.Caducidad AS CaducidadProducto, " +
                    "P.Categoria AS CategoriaProducto, " +
                    "P.Precio AS PrecioProducto, " +
                    "DV.Cantidad AS CantidadProducto, " +
                    "P.Estado AS EstadoProducto, " +
                    "P.FechaIngreso AS FechaIngresoProducto, " +
                    "(P.Precio * DV.Cantidad) AS TotalDetalle " + // Calcular el total
                    "FROM DetalleVenta AS DV " +
                    "INNER JOIN Productos AS P ON DV.IdProducto = P.IdProducto " +
                    "WHERE DV.IdVenta = " + idVenta + " ";

            rs = stm.executeQuery(sentencia);
            while (rs.next()) {
                Detalle = new MostrarDetalles(
                    rs.getInt("IdDetalleVenta"),
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
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (_conexion != null) {
                ClaseConexion.close(_conexion);
            }
        }
        return lista;
    }
    
    public float ObtenerTotalDineroDetallesVenta(int idVenta) throws SQLException, Exception {
        float totalDinero = 0;
        Connection _conexion = null;
        ResultSet rs = null;

        try {
            _conexion = ClaseConexion.getcConnection();
            Statement stm = _conexion.createStatement();

            String query = "SELECT SUM(p.Precio * dv.Cantidad * 1.13) AS TotalDineroConImpuesto " +
                            "FROM DetalleVenta dv " +
                            "INNER JOIN Productos p ON dv.IdProducto = p.IdProducto " +
                            "WHERE dv.IdVenta = " + idVenta;


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


    public int EliminarDetalle(int id) throws Exception {
        int resultado = -1;
        Connection _conexion = null;
        PreparedStatement ps = null;

        try {
            _conexion = ClaseConexion.getcConnection();

            String sentencia = "DELETE FROM DetalleVenta WHERE IdDetalleVenta = ?";
            ps = _conexion.prepareStatement(sentencia);
            ps.setInt(1, id);

            resultado = ps.executeUpdate();

            if (resultado > 0) {
                _mensaje = "Detalle eliminado de forma satisfactoria";
            } else {
                _mensaje = "No se pudo eliminar el detalle";
            }
        } catch (Exception ex) {
            _mensaje = "Error inesperado, intentar más tarde";
            throw ex;
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (_conexion != null) {
                ClaseConexion.close(_conexion);
            }
        }
        return resultado;
    }
    
    public List<MostrarFacturas> ListarFacturasVentas() throws Exception {
        ResultSet rs = null;
        MostrarFacturas factura;
        List<MostrarFacturas> lista = new ArrayList<>();
        Connection conexion = null;
        try {
            // Abrir la conexión
            conexion = ClaseConexion.getcConnection();
            Statement stm = conexion.createStatement();

            String sentencia = "SELECT V.IdVenta, " +
                "F.NombreCompleto AS Funcionario, " +
                "C.NombreCompleto AS Cliente, " +
                "V.PrecioTotal, " +
                "V.Fecha, " +
                "V.MetodoPago, " +
                "PR.Descripcion AS Producto, " +
                "PR.Precio AS PrecioProducto " +
                "FROM Venta V " +
                "INNER JOIN Funcionario F ON V.IdFuncionario = F.IdFuncionario " +
                "INNER JOIN Cliente C ON V.IdCliente = C.IdCliente " +
                "INNER JOIN DetalleVenta DV ON V.IdVenta = DV.IdVenta " +
                "INNER JOIN Productos PR ON DV.IdProducto = PR.IdProducto ";

            rs = stm.executeQuery(sentencia);
            while (rs.next()) {
                factura = new MostrarFacturas(
                    rs.getInt("IdVenta"),
                    rs.getString("Funcionario"),
                    rs.getString("Cliente"),
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
