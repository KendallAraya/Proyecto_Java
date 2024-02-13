/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entidades.Producto;
import LogicaNegocio.LNFacturaCompra;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AgregarProductoDetalle", urlPatterns = {"/AgregarProductoDetalle"})
public class AgregarProductoDetalle extends HttpServlet {

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
              LNFacturaCompra logica = new LNFacturaCompra();
              Producto producto = new Producto();
              int resultado;
              producto.setDescripcion(new String(request.getParameter("txtDescripcion").getBytes("ISO-8859-1"), "UTF-8"));
              
              // Obtengo el valor del campo de texto
              String fechaCaducidadStr = request.getParameter("txtCaducidad");
              producto.setCategoria(new String(request.getParameter("txtCategoria").getBytes("ISO-8859-1"), "UTF-8"));
              // Defino el formato de fecha esperado
              SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
              Date fechaCaducidadUtil = sdf.parse(fechaCaducidadStr);
              //java.util.Date a java.sql.Date
              java.sql.Date fechaCaducidadSql = new java.sql.Date(fechaCaducidadUtil.getTime());

              producto.setCaducidad(fechaCaducidadSql);

              producto.setPrecio(Float.parseFloat(request.getParameter("txtPrecio")));
              producto.setCantidad(Float.parseFloat(request.getParameter("txtCantidad")));
              
              int IdCompra = logica.ObtenerUltimoId();

              resultado = logica.InsertarProductoDetalle(producto, IdCompra);
              mensaje = logica.getMensaje();
              
              response.sendRedirect("frmDetalleCompra.jsp?mensajeEliminarDetalle=" + mensaje);
              
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
