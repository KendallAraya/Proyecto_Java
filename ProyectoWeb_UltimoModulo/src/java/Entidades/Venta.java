package Entidades;

import java.sql.Date;

public class Venta extends Factura{
    
     private int idVenta;
     private int idCliente;
     
     //Constructores
     public Venta(int idVenta, int idCliente, int idFuncionario, Date fecha, String metodoPago, float precioTotal, boolean existe) {
        super(idFuncionario, fecha, metodoPago, precioTotal, existe);
        this.idVenta = idVenta;
        this.idCliente = idCliente;
    }
     
    public Venta() {
        super();
        this.idVenta = 0;
        this.idCliente = 0;
    }
    
    //Metodos de acceso
    public int getIdVenta() {
        return idVenta;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }
     
}
