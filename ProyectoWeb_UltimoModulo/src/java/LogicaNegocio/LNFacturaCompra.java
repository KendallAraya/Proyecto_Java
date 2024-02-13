package LogicaNegocio;

import AccesoDatos.ADFacturaCompra;
import Entidades.MostrarDetalles;
import Entidades.Compra;
import Entidades.MostrarFacturas;
import Entidades.Producto;
import java.util.ArrayList;
import java.util.List;


public class LNFacturaCompra {
   //Atributos
    private String _mensaje;
    
    public String getMensaje() {
        return _mensaje;
    }
    
    public int InsertarCompra(Compra compra) throws Exception{
        int resultado = -1;
        ADFacturaCompra adfacturaCompra;
        
        try {
            adfacturaCompra = new ADFacturaCompra();
            resultado = adfacturaCompra.InsertarCompra(compra);
            _mensaje = adfacturaCompra.getMensaje();
            
        } catch (Exception ex) {
            throw ex;
        }
        return resultado;
    }
    
    public int InsertarProductoDetalle(Producto producto, int IdFactura) throws Exception{
        int resultado = -1;
        ADFacturaCompra adfacturaCompra;
        
        try {
            adfacturaCompra = new ADFacturaCompra();
            resultado = adfacturaCompra.InsertarProductoDetalle(producto,IdFactura);
            _mensaje = adfacturaCompra.getMensaje();
            
        } catch (Exception ex) {
            throw ex;
        }
        return resultado;
    }
    
    public int ObtenerUltimoId() throws Exception{
        int resultado = -1;
        ADFacturaCompra adfacturaCompra;
        
        try {
            adfacturaCompra = new ADFacturaCompra();
            resultado = adfacturaCompra.ObtenerUltimoId();
            _mensaje = adfacturaCompra.getMensaje();
            
        } catch (Exception ex) {
            throw ex;
        }
        return resultado;
    }
    
    public List<MostrarDetalles> ListarDetallesCompras_List(int id) throws Exception{
        List<MostrarDetalles> resultado = new ArrayList();
        ADFacturaCompra adfacturaCompra;
        try {
            adfacturaCompra=new ADFacturaCompra();
            resultado = adfacturaCompra.ListarDetallesCompras_List(id);
        } catch (Exception e) {
            throw e;
        }
        return resultado;
    }

    public float ObtenerTotalDineroDetallesCompra(int IdFactura) throws Exception{
        float resultado;
        ADFacturaCompra ADFacturaCompra;
        
        try {
            ADFacturaCompra = new ADFacturaCompra();
            resultado = ADFacturaCompra.ObtenerTotalDineroDetallesCompra(IdFactura);
            
        } catch (Exception ex) {
            throw ex;
        }
        
        return resultado;
    }
    
    public int EliminarDetalleCompra(int Id) throws Exception{
        int resultado;
        ADFacturaCompra ADFacturaCompra;
        
        try {
            ADFacturaCompra = new ADFacturaCompra();
            resultado = ADFacturaCompra.EliminarDetalle(Id);
            _mensaje = ADFacturaCompra.getMensaje();
            
        } catch (Exception ex) {
            throw ex;
        }
        
        return resultado;
    }
    
    public List<MostrarFacturas> ListarFacturasCompras() throws Exception{
        List<MostrarFacturas> resultado = new ArrayList();
        ADFacturaCompra adfacturaCompra;
        try {
            adfacturaCompra=new ADFacturaCompra();
            resultado = adfacturaCompra.ListarFacturasCompras();
        } catch (Exception e) {
            throw e;
        }
        return resultado;
    }
//    
}
