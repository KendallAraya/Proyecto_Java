package Entidades;

import java.sql.Date;

public class Producto {

    //Atributos
    private int idProducto;
    private String descripcion;
    private Date caducidad;
    private String categoria;
    private float precio;
    private float cantidad;
    private String estado;
    private Date fechaIngreso;
    
    //Constructores
    public Producto(int idProducto, String descripcion, Date caducidad, String categoria, float precio, float cantidad, String estado, Date fechaIngreso) {
        this.idProducto = idProducto;
        this.descripcion = descripcion;
        this.caducidad = caducidad;
        this.categoria = categoria;
        this.precio = precio;
        this.cantidad = cantidad;
        this.estado = estado;
        this.fechaIngreso = fechaIngreso;
    }
    
    public Producto() {
        this.idProducto = 0;
        this.descripcion = "";
        this.caducidad = null;
        this.categoria = "";
        this.precio = 0;
        this.cantidad = 0;
        this.estado = "";
        this.fechaIngreso = null;
    }
    
    //Metodos de acceso
    public int getIdProducto() {
        return idProducto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public Date getCaducidad() {
        return caducidad;
    }

    public String getCategoria() {
        return categoria;
    }

    public float getPrecio() {
        return precio;
    }

    public float getCantidad() {
        return cantidad;
    }

    public String getEstado() {
        return estado;
    }

    public Date getFechaIngreso() {
        return fechaIngreso;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setCaducidad(Date caducidad) {
        this.caducidad = caducidad;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public void setPrecio(float precio) {
        this.precio = precio;
    }

    public void setCantidad(float cantidad) {
        this.cantidad = cantidad;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }
    
}
