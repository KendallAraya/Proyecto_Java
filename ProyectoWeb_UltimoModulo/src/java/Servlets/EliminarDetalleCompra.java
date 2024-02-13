package Servlets;

import LogicaNegocio.LNFacturaCompra;
import java.io.*; //Imprimir variables en pantalla
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EliminarDetalleCompra")
public class EliminarDetalleCompra extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        
        //Indica el tipo de salida HTML
        response.setContentType("text/html;charset=UTF-8");
        //Para poder escribir en el html
        PrintWriter out = response.getWriter();
        try {
            LNFacturaCompra logica = new LNFacturaCompra();
            //Parametro de la Query String
            String id = request.getParameter("idDetalle");
            int codigo = Integer.parseInt(id);
            
            int resultado = logica.EliminarDetalleCompra(codigo);
            
            String mensaje = logica.getMensaje();
            //Codificacion de caracteres para mostrar en HTML
            mensaje = URLEncoder.encode(mensaje, "UTF-8");
            //Redireccionamos la pagina frmListarCliente
            //Y enviamos por parametro mensaje 
            response.sendRedirect("frmDetalleCompra.jsp?mensajeEliminarDetalle=" + mensaje);
        } catch (Exception ex) {
            out.print(ex.getMessage());//Para escribir en html 
        }
        
    }//Fin 
    
}
