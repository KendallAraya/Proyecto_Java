<%-- 
    Document   : frmListarClientes
    Created on : Aug 28, 2023, 8:13:27 AM
    Author     : Admin
--%>
<%@page import="Entidades.Funcionario" %>
<%@page import="LogicaNegocio.LNFuncionario" %>
<%@page import="java.util.List" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Funcionarios</title>
        <link href="lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/fontawesome-free-5.14.0-web/css/all.min.css" rel="stylesheet" type="text/css"/>
        <style>
            body {
                background-color: #EE706D;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 200 200'%3E%3Cdefs%3E%3ClinearGradient id='a' gradientUnits='userSpaceOnUse' x1='100' y1='33' x2='100' y2='-3'%3E%3Cstop offset='0' stop-color='%23000' stop-opacity='0'/%3E%3Cstop offset='1' stop-color='%23000' stop-opacity='1'/%3E%3C/linearGradient%3E%3ClinearGradient id='b' gradientUnits='userSpaceOnUse' x1='100' y1='135' x2='100' y2='97'%3E%3Cstop offset='0' stop-color='%23000' stop-opacity='0'/%3E%3Cstop offset='1' stop-color='%23000' stop-opacity='1'/%3E%3C/linearGradient%3E%3C/defs%3E%3Cg fill='%23d15756' fill-opacity='0.6'%3E%3Crect x='100' width='100' height='100'/%3E%3Crect y='100' width='100' height='100'/%3E%3C/g%3E%3Cg fill-opacity='0.5'%3E%3Cpolygon fill='url(%23a)' points='100 30 0 0 200 0'/%3E%3Cpolygon fill='url(%23b)' points='100 100 0 130 0 100 200 100 200 130'/%3E%3C/g%3E%3C/svg%3E");
            }

            .bg-custom {
                background-color: #EE8B8B;
                font-family: Impact, sans-serif;
            }
        </style>
    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-sm navbar-toggleable-sm navbar-light box-shadow mb-3 bg-custom">
                <div class="container">
                    <a class="navbar-brand" href="index.html">Sistema Facturación <i class="fas fa-tasks"></i></a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target=".navbar-collapse" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="navbar-collapse collapse d-sm-inline-flex flex-sm-row-reverse">
                        <ul class="navbar-nav flex-grow-1">
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="index.html">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="frmListarFuncionarios.jsp">Funcionarios</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="frmListarClientes.jsp">Clientes</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="FrmCompra.jsp">Factura de Compra</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="FrmVenta.jsp">Factura de Venta</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="frmListarFacturas.jsp">Listado de Facturas</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        
        <div class="container bg-custom">
            <div class="card-header">
                <h1>Listado de Funcionarios</h1>
            </div>
            <br><!-- El formulario se carga a si mismo -->
            <form action="frmListarFuncionarios.jsp" method="post">

                <div class="form-group">
                    <div class="input-group">
                        <input type="text" id="txtNombre" name="txtNombre" placeholder="Buscar por Nombre" class="form-control">
                        <input type="submit" name="btnBuscar" value="Buscar" class="btn btn-primary"> 
                        <br>
                    </div>
                </div>

                <!<!-- Encabezado de tabla -->
                <table class="table">
                    <thead>
                        <tr id="titulos">
                            <th>Codigo</th>
                            <th>Cedula</th>
                            <th>Nombre Completo</th>
                            <th>Ocupacion</th>
                            <th>Edad</th>
                            <th>Telefono</th>
                            <th>Direccion</th>
                            <th>Correo</th>
                            <th>Opciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            String nombre = "";
                            String condicion = "";

                            if(request.getParameter("txtNombre")!= null){
                                nombre = request.getParameter("txtNombre");
                                condicion = "NombreCompleto LIKE '%" + nombre +"%' ";
                            }
                            LNFuncionario logica = new LNFuncionario();
                            List<Funcionario> dato;
                            dato=logica.ListarFuncionario_List(condicion);
                            for (Funcionario registros : dato) {

                        %>
                            <tr>
                                <% int codigo = registros.getIdFuncionario();

                                %>
                                <!-- No termina con ; potque es una exprecion -->
                                <td><%= codigo %></td>
                                <td><%= registros.getCedula()%></td>
                                <td><%= registros.getNombreCompleto()%></td>
                                <td><%= registros.getOcupacion()%></td>
                                <td><%= registros.getEdad()%></td>
                                <td><%= registros.getTelefono()%></td>
                                <td><%= registros.getDireccion()%></td>
                                <td><%= registros.getCorreo()%></td>
                                <td>
                                    <a href="frmFuncionarios.jsp?idCrearModificar=<%= codigo %>"><i class="fas fa-user-edit"></i></a>
                                    <a href="EliminarFuncionario?idFuncionario=<%= codigo %>"><i class="fas fa-trash-alt"></i></a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                    <br>
                    <%  //si la variable mesaje tiene algo 
                        if (request.getParameter("mensajeEliminarFuncionario") != null) {
                                out.print("<p class='text-danger'>" + new String
                                (request.getParameter("mensajeEliminarFuncionario").getBytes("ISO-8859-1"), "UTF-8")+"</p>");
                            }
                        %>
                    <a href="frmFuncionarios.jsp?idCrearModificar=-1" class="btn btn-primary">Agregar Funcionario</a>
                    <a href="index.html" class="btn btn-primary">Regresar</a>
            </form>
            <br><br><br><br>       
        </div>
        <script src="lib/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>
