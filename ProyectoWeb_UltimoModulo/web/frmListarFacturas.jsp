<%-- 
    Document   : frmListarFacturas
    Created on : Sep 9, 2023, 12:06:24 PM
    Author     : Admin
--%>

<%@page import="LogicaNegocio.LNFacturaVenta"%>
<%@page import="Entidades.MostrarFacturas"%>
<%@page import="Entidades.Compra"%>
<%@page import="java.util.List"%>
<%@page import="LogicaNegocio.LNFacturaCompra"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Facturas</title>
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
                <h1 class="text-center">Listado de Facturas Compra</h1>
            </div>
            <br><!-- El formulario se carga a si mismo -->
            <form action="">
                <!<!-- Encabezado de tabla -->
                <table class="table">
                    <thead>
                        <tr id="titulos">
                            <th>Id. Compra</th>
                            <th>Funcionario</th>
                            <th>Proveedor</th>
                            <th>Precio Total</th>
                            <th>Fecha</th>
                            <th>Metodo Pago</th>
                            <th>Producto</th>
                            <th>Precio Producto</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            LNFacturaCompra logica = new LNFacturaCompra();
                            List<MostrarFacturas> dato;
                            dato=logica.ListarFacturasCompras();
                            for (MostrarFacturas registros : dato) {

                        %>
                            <tr>
                                <!-- No termina con ; potque es una exprecion -->
                                <td><%= registros.getIdCompra() %></td>
                                <td><%= registros.getFuncionario() %></td>
                                <td><%= registros.getProveedor() %></td>
                                <td><%= registros.getPrecioTotal() %></td>
                                <td><%= registros.getFecha() %></td>
                                <td><%= registros.getMetodoPago() %></td>
                                <td><%= registros.getProducto() %></td>
                                <td><%= registros.getPrecioProducto() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </form>
        </div>
        <br><br>
        <div class="container bg-custom">
            <div class="card-header">
                <h1 class="text-center">Listado de Facturas Ventas</h1>
            </div>
                    
            <br><!-- El formulario se carga a si mismo -->
            <form action="">
                <!<!-- Encabezado de tabla -->
                <table class="table">
                    <thead>
                        <tr id="titulos">
                            <th>Id. Compra</th>
                            <th>Funcionario</th>
                            <th>Cliente</th>
                            <th>Precio Total</th>
                            <th>Fecha</th>
                            <th>Metodo Pago</th>
                            <th>Producto</th>
                            <th>Precio Producto</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            LNFacturaVenta logicaV = new LNFacturaVenta();
                            List<MostrarFacturas> datoV;
                            datoV=logicaV.ListarFacturasVentas();
                            for (MostrarFacturas registrosV : datoV) {

                        %>
                            <tr>
                                <!-- No termina con ; potque es una exprecion -->
                                <td><%= registrosV.getIdCompra() %></td>
                                <td><%= registrosV.getFuncionario() %></td>
                                <td><%= registrosV.getProveedor() %></td>
                                <td><%= registrosV.getPrecioTotal() %></td>
                                <td><%= registrosV.getFecha() %></td>
                                <td><%= registrosV.getMetodoPago() %></td>
                                <td><%= registrosV.getProducto() %></td>
                                <td><%= registrosV.getPrecioProducto() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </form>
            <a href="index.html" class="btn btn-secondary">Regresar</a>   
            <br><br>
        </div>
        <script src="lib/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>
