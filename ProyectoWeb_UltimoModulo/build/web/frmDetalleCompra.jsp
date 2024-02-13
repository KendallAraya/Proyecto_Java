<%-- 
    Document   : frmDetalleCompra
    Created on : Sep 8, 2023, 9:11:11 AM
    Author     : Admin
--%>

<%@page import="Entidades.MostrarDetalles"%>
<%@page import="Entidades.Producto"%>
<%@page import="java.util.List"%>
<%@page import="LogicaNegocio.LNFacturaCompra"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Productos</title>
        <link href="lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/bootstrap-datepicker/css/bootstrap-datepicker3.standalone.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/fontawesome-free-5.14.0-web/css/all.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/DataTables/datatables.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/Estilos.css" rel="stylesheet" type="text/css"/>
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
        <br><br>
        <div class="container bg-custom">
                <div class="row">
                    <div class="col-10"><h1>Agregar Productos</h1></div>
                </div>
                    <% 
                        Producto producto = new Producto();
                    %>
                <form action="AgregarProductoDetalle" method="post" id="form_AgregarDetalleProducto"> 
                    <div>
                        <label for="txtDescripcion" class="control-label">Descripcion</label>
                        <input type="text" id="txtDescripcion" name="txtDescripcion" value="" class="form-control">
                    </div>
                    <div>
                        <label for="txtCaducidad" class="control-label">Fecha de Caducidad</label>
                        <input type="text" id="txtCaducidad" name="txtCaducidad" value="" class="datepicker form-control">
                    </div>
                    <div>
                        <label for="txtCategoria" class="control-label">Categoria</label>
                        <input type="text" id="txtCategoria" name="txtCategoria" value="" class="form-control">
                    </div>
                    <div>
                        <label for="txtPrecio" class="control-label">Precio</label>
                        <input type="text" id="txtPrecio" name="txtPrecio" value="" class="form-control">
                    </div>
                    <div>
                        <label for="txtCantidad" class="control-label">Cantidad</label>
                        <input type="text" id="txtCantidad" name="txtCantidad" value="" class="form-control">
                    </div>
                    <br>
                    <div class="form-group">
                        <input type="submit" id="BtnGuardar" name="Guardar" value="Agregar y Guardar" class="btn btn-primary">
                    </div>
                </form>
                <!-- Encabezado de tabla -->
                <div class="row">
                    <div class="col-10"><h1>Productos Agregados</h1></div>
                </div>
                <table class="table">
                    <thead>
                        <tr id="titulos">
                            <th>Id Detalle</th>
                            <th>Descripcion</th>
                            <th>Caducidad</th>
                            <th>Categotia</th>
                            <th>Precio</th>
                            <th>Cantidad</th>
                            <th>Estado</th>
                            <th>Fecha Ingreso</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            LNFacturaCompra logicaD = new LNFacturaCompra();
                            List<MostrarDetalles> datoD;
                            datoD=logicaD.ListarDetallesCompras_List(logicaD.ObtenerUltimoId());
                            for (MostrarDetalles registros : datoD) {

                        %>
                            <tr>
                                <% int codigo = registros.getIdDetalleCompra();

                                %>
                                <!-- No termina con ; potque es una exprecion -->
                                <td><%= codigo %></td>
                                <td><%= registros.getDescripcion()%></td>
                                <td><%= registros.getCaducidad()%></td>
                                <td><%= registros.getCategoria()%></td>
                                <td><%= registros.getPrecio()%></td>
                                <td><%= registros.getCantidad()%></td>
                                <td><%= registros.getEstado()%></td>
                                <td><%= registros.getFechaIngreso()%></td>
                                <td><%= registros.getTotalDetalle()%></td>
                                <td>
                                    <a href="EliminarDetalleCompra?idDetalle=<%= codigo %>"><i class="fas fa-trash-alt"></i></a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                    <br>
                    <%  //si la variable mesaje tiene algo 
                        if (request.getParameter("mensajeEliminarDetalle") != null) {
                                out.print("<p class='text-danger'>" + new String
                                (request.getParameter("mensajeEliminarDetalle").getBytes("ISO-8859-1"), "UTF-8")+"</p>");
                            }
                        %>
                    <div style="text-align: center;">
                        <% 
                        int IdCompra = logicaD.ObtenerUltimoId();
                        float Total = logicaD.ObtenerTotalDineroDetallesCompra(IdCompra);
                        if (Total > 0) {
                        %>
                            <!-- si existe muestra el codigo -->
                            <label for="txtTotal" class="control-label">Total de la factura con IVA</label>
                            <input type="text" id="txtTotal" name="txtTotal" value="₡<%=Total%>" class="form-control" style="max-width: 200px; margin: 0 auto;" readonly="true">
                            <%}else{%>
                            <input type="hidden" id="txtTotal" name="txtTotal" value="-1">
                            <%}%>
                    </div>
                    <br>
                    <div class="form-group">
                        <input type="button" id="BtnListo" name="Listo" value="Terminar Factura" class="btn btn-primary">
                        <input type="button" id="BtnCancelar" name="Cancelar" value="Cancelar" class="btn btn-danger">
                    </div>

            </div> 
                    
        <script src="lib/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <script src="lib/jquery-validation/dist/jquery.validate.js" type="text/javascript"></script>
        <script src="lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap-datepicker/locales/bootstrap-datepicker.es.min.js" type="text/javascript"></script>
        <script src="lib/DataTables/datatables.min.js" type="text/javascript"></script>
        <script src="lib/DataTables/DataTables-1.10.21/js/dataTables.bootstrap4.min.js" type="text/javascript"></script>
        
        <script>
            $(document).ready(function() {
                //Mostrar calendario
                $('.datepicker').datepicker({
                    format:'yyyy-mm-dd',
                    autoclose:true,
                    language:'es'
                });
                $("#form_AgregarDetalleProducto").validate({
                    rules: {
                        txtDescripcion: {
                            required: true,
                            maxlength: 255 
                        },
                        txtCaducidad: {
                            required: true,
                        },
                        txtCategoria: {
                            required: true,
                            maxlength: 50 
                        },
                        txtPrecio: {
                            required: true,
                            number: true, 
                            min: 0 
                        },
                        txtCantidad: {
                            required: true,
                            number: true
                        }
                    },
                    messages: {
                        txtDescripcion: {
                            required: "El campo Descripcion es obligatorio.",
                            maxlength: "La longitud maxima es de 255 caracteres."
                        },
                        txtCaducidad: {
                            required: "El campo Fecha de Caducidad es obligatorio.",
                        },
                        txtCategoria: {
                            required: "El campo Categoria es obligatorio.",
                            maxlength: "La longitud maxima es de 50 caracteres."
                        },
                        txtPrecio: {
                            required: "El campo Precio es obligatorio.",
                            number: "Ingrese un número valido.",
                            min: "El precio no puede ser negativo."
                        },
                        txtCantidad: {
                            required: "El campo Cantidad es obligatorio.",
                            number: "Ingrese un número valido."
                        }
                    },
                    errorElement: 'span'
                });

                $("#BtnListo").click(function (e) {

                    alert("La factura ya ha sido creada.");
                    window.location.href = "index.html";

                });

                $("#BtnCancelar").click(function (e) {

                    alert("La creacion de la factura a sido cancelada.");
                    window.location.href = "index.html";


                });

            });
        </script>
    </body>
</html>
