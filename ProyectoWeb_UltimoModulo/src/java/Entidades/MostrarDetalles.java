package Entidades;

import java.util.Date;

public class MostrarDetalles {
    
    // Atributos
    private int idDetalle;
    private String descripcion;
    private Date caducidad;
    private String categoria;
    private float precio;
    private float cantidad;
    private String estado;
    private Date fechaIngreso;
    private float TotalDetalle;
    
    // Constructores
    public MostrarDetalles(int idDetalle, String descripcion, Date caducidad, String categoria, float precio, float cantidad, String estado, Date fechaIngreso, float TotalDetalle) {
        this.idDetalle = idDetalle;
        this.descripcion = descripcion;
        this.caducidad = caducidad;
        this.categoria = categoria;
        this.precio = precio;
        this.cantidad = cantidad;
        this.estado = estado;
        this.fechaIngreso = fechaIngreso;
        this.TotalDetalle = TotalDetalle;
    }
    
    public MostrarDetalles() {
        this.idDetalle = 0;
        this.descripcion = "";
        this.caducidad = null;
        this.categoria = "";
        this.precio = 0.0f;
        this.cantidad = 0.0f;
        this.estado = "";
        this.fechaIngreso = null;
        this.TotalDetalle = 0.0f;
    }
    
    // Métodos de acceso
    public int getIdDetalleCompra() {
        return idDetalle;
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

    public void setIdDetalleCompra(int idDetalleCompra) {
        this.idDetalle = idDetalleCompra;
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
    
    public void setTotalDetalle(float TotalDetalle) {
        this.TotalDetalle = TotalDetalle;
    }

    public float getTotalDetalle() {
        return TotalDetalle;
    }
}

