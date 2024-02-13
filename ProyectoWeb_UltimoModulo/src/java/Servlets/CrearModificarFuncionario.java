/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Entidades.Funcionario;
import LogicaNegocio.LNFuncionario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CrearModificarFuncionario")
public class CrearModificarFuncionario extends HttpServlet {

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
              LNFuncionario logica = new LNFuncionario();
              Funcionario funcionario = new Funcionario();
              int resultado;
              funcionario.setIdFuncionario(Integer.parseInt(request.getParameter("txtCodigo")));
              funcionario.setCedula(new String(request.getParameter("txtCedula").getBytes("ISO-8859-1"), "UTF-8"));
              funcionario.setNombreCompleto(new String(request.getParameter("txtNombre").getBytes("ISO-8859-1"), "UTF-8"));
              funcionario.setEdad(Integer.parseInt(request.getParameter("txtEdad")));
              funcionario.setTelefono(request.getParameter("txtTelefono"));
              funcionario.setDireccion(new String(request.getParameter("txtDireccion").getBytes("ISO-8859-1"), "UTF-8"));
              funcionario.setCorreo(new String(request.getParameter("txtCorreo").getBytes("ISO-8859-1"), "UTF-8"));
              funcionario.setOcupacion(new String(request.getParameter("selOcupacion").getBytes("ISO-8859-1"), "UTF-8"));
              
              resultado = logica.InsertarFuncionario(funcionario);
              mensaje = logica.getMensaje();
                
              response.sendRedirect("frmListarFuncionarios.jsp?mensajeEliminarFuncionario=" + mensaje);
              
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
