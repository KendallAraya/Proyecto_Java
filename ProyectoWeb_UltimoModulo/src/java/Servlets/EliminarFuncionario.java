package Servlets;

import Entidades.Funcionario;
import LogicaNegocio.LNFuncionario;
import java.io.*; //Imprimir variables en pantalla
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EliminarFuncionario")
public class EliminarFuncionario extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        
        //Indica el tipo de salida HTML
        response.setContentType("text/html;charset=UTF-8");
        //Para poder escribir en el html
        PrintWriter out = response.getWriter();
        try {
            LNFuncionario logica = new LNFuncionario();
            //Parametro de la Query String
            String id = request.getParameter("idFuncionario");
            int codigo = Integer.parseInt(id);
            Funcionario funcionario = new Funcionario();
            
            funcionario.setIdFuncionario(codigo);
            
            int resultado = logica.EliminarFuncionario(funcionario);
            
            String mensaje = logica.getMensaje();
            //Codificacion de caracteres para mostrar en HTML
            mensaje = URLEncoder.encode(mensaje, "UTF-8");
            //Y enviamos por parametro mensaje 
            response.sendRedirect("frmListarFuncionarios.jsp?mensajeEliminarFuncionario=" 
                    + mensaje + "&resultado" + resultado);
        } catch (Exception ex) {
            out.print(ex.getMessage());//Para escribir en html 
        }
        
    }//Fin 
    
}//Fin Eliminar Funcionario
