/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Entidades.Cliente;
import LogicaNegocio.LNCliente;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CrearModificarCliente")
public class CrearModificarCliente extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String mensaje = "";
          try {
              LNCliente logica = new LNCliente();
              Cliente cliente = new Cliente();
              int resultado;
              cliente.setIdCliente(Integer.parseInt(request.getParameter("txtCodigo")));
              cliente.setCedula(new String(request.getParameter("txtCedula").getBytes("ISO-8859-1"), "UTF-8"));
              cliente.setNombreCompleto(new String(request.getParameter("txtNombre").getBytes("ISO-8859-1"), "UTF-8"));
              cliente.setEdad(Integer.parseInt(request.getParameter("txtEdad")));
              cliente.setTelefono(request.getParameter("txtTelefono"));
              cliente.setDireccion(new String(request.getParameter("txtDireccion").getBytes("ISO-8859-1"), "UTF-8"));
              cliente.setCorreo(new String(request.getParameter("txtCorreo").getBytes("ISO-8859-1"), "UTF-8"));
              
              resultado = logica.InsertarCliente(cliente);
              mensaje = logica.getMensaje();
                
              response.sendRedirect("frmListarClientes.jsp?mensajeEliminarCliente=" + mensaje);
              
        } catch (Exception e) {
            out.print(e.getMessage());
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
