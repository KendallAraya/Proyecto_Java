package Servlets;

import Entidades.Cliente;
import LogicaNegocio.LNCliente;
import java.io.*; //Imprimir variables en pantalla
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EliminarCliente")
public class EliminarCliente extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        
        //Indica el tipo de salida HTML
        response.setContentType("text/html;charset=UTF-8");
        //Para poder escribir en el html
        PrintWriter out = response.getWriter();
        try {
            LNCliente logica = new LNCliente();
            //Parametro de la Query String
            String id = request.getParameter("idCliente");
            int codigo = Integer.parseInt(id);
            Cliente cliente = new Cliente();
            
            cliente.setIdCliente(codigo);
            
            int resultado = logica.EliminarCliente(cliente);
            
            String mensaje = logica.getMensaje();
            //Codificacion de caracteres para mostrar en HTML
            mensaje = URLEncoder.encode(mensaje, "UTF-8");
            //Redireccionamos la pagina frmListarCliente
            //Y enviamos por parametro mensaje 
            response.sendRedirect("frmListarClientes.jsp?mensajeEliminarCliente=" 
                    + mensaje + "&resultado" + resultado);
        } catch (Exception ex) {
            out.print(ex.getMessage());//Para escribir en html 
        }
        
    }//Fin 
    
}//Fin EliminarCliente
