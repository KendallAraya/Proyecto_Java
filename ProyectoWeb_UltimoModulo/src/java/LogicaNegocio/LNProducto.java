/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package LogicaNegocio;

import AccesoDatos.ADProducto;
import Entidades.Producto;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class LNProducto {
    //Atributos
    private String _mensaje;
    
    public String getMensaje() {
        return _mensaje;
    }
    
    public List<Producto> ListarProducto_List(String condicion) throws Exception{
        List<Producto> resultado = new ArrayList();
        ADProducto adproducto;
        try {
            adproducto=new ADProducto();
            resultado = adproducto.ListarProducto_List(condicion);
        } catch (Exception e) {
            throw e;
        }
        return resultado;
    }
}
