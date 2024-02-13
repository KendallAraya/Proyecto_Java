/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidades;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class MostrarFacturas {
    // Atributos
    private int idCompra;
    private String funcionario;
    private String proveedor_cliente;
    private float precioTotal;
    private Date fecha;
    private String metodoPago;
    private String producto;
    private float precioProducto;
    
    // Constructores
    public MostrarFacturas(int idCompra, String funcionario, String proveedor_cliente, float precioTotal, Date fecha, String metodoPago, String producto, float precioProducto) {
        this.idCompra = idCompra;
        this.funcionario = funcionario;
        this.proveedor_cliente = proveedor_cliente;
        this.precioTotal = precioTotal;
        this.fecha = fecha;
        this.metodoPago = metodoPago;
        this.producto = producto;
        this.precioProducto = precioProducto;
    }
    
    // Métodos de acceso
    public int getIdCompra() {
        return idCompra;
    }

    public String getFuncionario() {
        return funcionario;
    }

    public String getProveedor() {
        return proveedor_cliente;
    }

    public float getPrecioTotal() {
        return precioTotal;
    }

    public Date getFecha() {
        return fecha;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public String getProducto() {
        return producto;
    }

    public float getPrecioProducto() {
        return precioProducto;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public void setFuncionario(String funcionario) {
        this.funcionario = funcionario;
    }

    public void setProveedor(String proveedor_cliente) {
        this.proveedor_cliente = proveedor_cliente;
    }

    public void setPrecioTotal(float precioTotal) {
        this.precioTotal = precioTotal;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public void setPrecioProducto(float precioProducto) {
        this.precioProducto = precioProducto;
    }
}
