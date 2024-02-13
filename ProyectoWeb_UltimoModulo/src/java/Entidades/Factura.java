package Entidades;

import java.sql.Date;

public class Factura {

    private int idFuncionario;
    private Date fecha; 
    private String metodoPago;
    private float precioTotal;
    private boolean existe;
    
    //Constructores
    public Factura(int idFuncionario, Date fecha, String metodoPago, float precioTotal, boolean existe) {
        this.idFuncionario = idFuncionario;
        this.fecha = fecha;
        this.metodoPago = metodoPago;
        this.precioTotal = precioTotal;
        this.existe = existe;
    }
    
    public Factura() {
        this.idFuncionario = 0;
        this.fecha = new Date(System.currentTimeMillis());
        this.metodoPago = "";
        this.precioTotal = 0;
        this.existe = false;
    }
    
    //Metodos de acceso
    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public void setPrecioTotal(float precioTotal) {
        this.precioTotal = precioTotal;
    }

    public int getIdFuncionario() {
        return idFuncionario;
    }

    public Date getFecha() {
        return fecha;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public float getPrecioTotal() {
        return precioTotal;
    }
    
    public void setExiste(boolean existe) {
        this.existe = existe;
    }

    public boolean isExiste() {
        return existe;
    }
}
