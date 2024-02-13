package Entidades;

import java.sql.Date;

public class Compra extends Factura{
    
    private int idCompra;
    private int idProveedor;
    
    //Constructores
    public Compra(int idCompra, int idProveedor, int idFuncionario, Date fecha, String metodoPago, float precioTotal, boolean existe) {
        super(idFuncionario, fecha, metodoPago, precioTotal, existe);
        this.idCompra = idCompra;
        this.idProveedor = idProveedor;
    }
    
    public Compra() {
        super();
        this.idCompra = 0;
        this.idProveedor = 0;
    }
    
    //Metodos de acceso 
    public int getIdCompra() {
        return idCompra;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }
    
}
