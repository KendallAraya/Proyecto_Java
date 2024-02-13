package LogicaNegocio;

import AccesoDatos.ADFacturaVenta;
import Entidades.DetalleVenta;
import Entidades.MostrarDetalles;
import Entidades.MostrarFacturas;
import Entidades.Venta;
import java.util.ArrayList;
import java.util.List;


public class LNFacturaVenta {
    //Atributos
    private String _mensaje;
    
    public String getMensaje() {
        return _mensaje;
    }
    
    public int InsertarVenta(Venta venta) throws Exception{
        int resultado = -1;
        ADFacturaVenta adfacturaVenta;
        
        try {
            adfacturaVenta = new ADFacturaVenta();
            resultado = adfacturaVenta.InsertarVenta(venta);
            _mensaje = adfacturaVenta.getMensaje();
            
        } catch (Exception ex) {
            throw ex;
        }
        return resultado;
    }
    
    public int InsertarDetalleVenta(DetalleVenta detalle, int IdFactura) throws Exception{
        int resultado = -1;
        ADFacturaVenta adfacturaVenta;
        
        try {
            adfacturaVenta = new ADFacturaVenta();
            resultado = adfacturaVenta.InsertarDetalleVenta(detalle,IdFactura);
            _mensaje = adfacturaVenta.getMensaje();
            
        } catch (Exception ex) {
            throw ex;
        }
        return resultado;
    }
    
    public int ObtenerUltimoId() throws Exception{
        int resultado = -1;
        ADFacturaVenta adfacturaVenta;
        
        try {
            adfacturaVenta = new ADFacturaVenta();
            resultado = adfacturaVenta.ObtenerUltimoId();
            _mensaje = adfacturaVenta.getMensaje();
            
        } catch (Exception ex) {
            throw ex;
        }
        return resultado;
    }
    
    public List<MostrarDetalles> ListarDetallesVenta_List(int id) throws Exception{
        List<MostrarDetalles> resultado = new ArrayList();
        ADFacturaVenta adfacturaVenta;
        try {
            adfacturaVenta=new ADFacturaVenta();
            resultado = adfacturaVenta.ListarDetallesVenta_List(id);
        } catch (Exception e) {
            throw e;
        }
        return resultado;
    }
    
    public float ObtenerTotalDineroDetallesVenta(int IdFactura) throws Exception{
        float resultado;
        ADFacturaVenta adfacturaVenta;
        
        try {
            adfacturaVenta = new ADFacturaVenta();
            resultado = adfacturaVenta.ObtenerTotalDineroDetallesVenta(IdFactura);
            
        } catch (Exception ex) {
            throw ex;
        }
        
        return resultado;
    }
    
    public int EliminarDetalleVenta(int Id) throws Exception{
        int resultado;
        ADFacturaVenta adfacturaVenta;
        
        try {
            adfacturaVenta = new ADFacturaVenta();
            resultado = adfacturaVenta.EliminarDetalle(Id);
            _mensaje = adfacturaVenta.getMensaje();
            
        } catch (Exception ex) {
            throw ex;
        }
        
        return resultado;
    }
    
    public List<MostrarFacturas> ListarFacturasVentas() throws Exception{
        List<MostrarFacturas> resultado = new ArrayList();
        ADFacturaVenta adfacturaVenta;
        try {
            adfacturaVenta=new ADFacturaVenta();
            resultado = adfacturaVenta.ListarFacturasVentas();
        } catch (Exception e) {
            throw e;
        }
        return resultado;
    }
}
