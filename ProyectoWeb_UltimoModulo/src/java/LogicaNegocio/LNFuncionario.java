package LogicaNegocio;

import AccesoDatos.ADFuncionarios;
import Entidades.Funcionario;
import java.util.ArrayList;
import java.util.List;


public class LNFuncionario {
    //Atributos
    private String _mensaje;
    
    public String getMensaje() {
        return _mensaje;
    }
    
    public int InsertarFuncionario(Funcionario funcionario) throws Exception{
        
        int id = -1;
        ADFuncionarios adFuncionario;
        try {
            adFuncionario = new ADFuncionarios();
            id = adFuncionario.InsertarFuncionario(funcionario);
            _mensaje = adFuncionario.getMensaje();
            
        } catch (Exception ex) {
            throw ex;
        }
        
        return id;
    }
    
    public List<Funcionario> ListarFuncionario_List(String condicion) throws Exception{
        List<Funcionario> resultado = new ArrayList();
        ADFuncionarios adcliente;
        try {
            adcliente=new ADFuncionarios();
            resultado = adcliente.ListarFuncionarios_List(condicion);
        } catch (Exception e) {
            throw e;
        }
        return resultado;
    }
    
    public Funcionario ObtenerFuncionario(String condicion) throws Exception{
        Funcionario cliente;
        ADFuncionarios ADfuncionarios;
        
        try {
            ADfuncionarios = new ADFuncionarios();
            cliente = ADfuncionarios.ObtenerFuncionario(condicion);
            if (cliente.isExiste()) {
                _mensaje = "Cliente recuperado";
            }
            else{
                _mensaje = "Cliente no existe en la BD";
            }
            
        } catch (Exception ex) {
            throw ex;
        }
        return cliente;
    }

    public int EliminarFuncionario(Funcionario cliente) throws Exception{
        int resultado = -1;
        ADFuncionarios ADfuncionarios;
        
        try {
            ADfuncionarios = new ADFuncionarios();
            resultado = ADfuncionarios.EliminarFuncionario(cliente);
            _mensaje = ADfuncionarios.getMensaje();
            
    } catch (Exception ex) {
            throw ex;
        }
        return resultado;
    }
}
