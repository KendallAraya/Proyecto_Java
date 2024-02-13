package Entidades;

public class DetalleVenta {

    private int idDetallaVenta; 
    private int idVenta; 
    private float cantidad;
    private int idProducto; 
    
    //Constructor
    public DetalleVenta(int idDetallaVenta, int idVenta, int idProducto, float cantidad) {
        this.idDetallaVenta = idDetallaVenta;
        this.idVenta = idVenta;
        this.idProducto = idProducto;
        this.cantidad = cantidad;
    }
    
    public DetalleVenta() {
        this.idDetallaVenta = 0;
        this.idVenta = 0;
        this.cantidad = 0;
        this.idProducto = 0;
    }
    
    //Metodos de acceso
    public int getIdDetallaVenta() {
        return idDetallaVenta;
    }

    public int getIdVenta() {
        return idVenta;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdDetallaVenta(int idDetallaVenta) {
        this.idDetallaVenta = idDetallaVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }
    
    public float getCantidad() {
        return cantidad;
    }

    public void setCantidad(float cantidad) {
        this.cantidad = cantidad;
    }
}
