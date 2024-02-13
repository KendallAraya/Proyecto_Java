package LogicaNegocio;

import AccesoDatos.ADProveedor;
import Entidades.Proveedor;
import java.util.ArrayList;
import java.util.List;

public class LNProveedor {
    //Atributos
    private String _mensaje;
    
    public String getMensaje() {
        return _mensaje;
    }
    
    public List<Proveedor> ListarProveedor_List(String condicion) throws Exception{
        List<Proveedor> resultado = new ArrayList();
        ADProveedor aDProveedor;
        try {
            aDProveedor=new ADProveedor();
            resultado = aDProveedor.ListarProveedor_List(condicion);
        } catch (Exception e) {
            throw e;
        }
        return resultado;
    }
}
