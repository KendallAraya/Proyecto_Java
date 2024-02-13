<%-- 
    Document   : frmDetalleCompra
    Created on : Sep 8, 2023, 9:11:11 AM
    Author     : Admin
--%>

<%@page import="LogicaNegocio.LNFacturaVenta"%>
<%@page import="Entidades.MostrarDetalles"%>
<%@page import="LogicaNegocio.LNProducto"%>
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
                    <div class="col-10"><h1 class="text-center">Agregar Productos</h1></div>
                </div>
                <br><br>
                <form action="AgregarDetalleVenta" method="post" id="form_AgregarDetalleVenta"> 
                     <div class="form-group">
                        <div class="input-group">
                            <input type="hidden" id="txtIdProducto" name="txtIdProducto" value="" readonly class="form-control">
                            <input type="text" id="txtDescripcion" name="txtDescripcion" value="" readonly class="form-control" placeholder="Seleccione un Producto">
                            <a id="btnBuscar" class="btn btn-success" data-toggle="modal" data-target="#buscarProducto">
                                <i class="fas fa-search"></i>
                            </a>
                            <input type="text" id="txtPrecio" name="txtPrecio" value="" class="form-control" placeholder="Precio" disabled>
                            <input type="text" id="txtExistencias" name="txtExistencias" value="" class="form-control" placeholder="Existencias" disabled>
                            <input type="text" id="txtCantidad" name="txtCantidad" value="" class="form-control" placeholder="Cantidad">
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="submit" id="BtnGuardar" name="Guardar" value="Agregar y Guardar" class="btn btn-primary" disabled>
                    </div>
                </form>
                <br>
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
                            <th>Categoria</th>
                            <th>Precio</th>
                            <th>Cantidad</th>
                            <th>Estado</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            LNFacturaVenta logicaV = new LNFacturaVenta();
                            List<MostrarDetalles> datoV;
                            datoV=logicaV.ListarDetallesVenta_List(logicaV.ObtenerUltimoId());
                            for (MostrarDetalles registros : datoV) {

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
                                <td><%= registros.getTotalDetalle()%></td>
                                <td>
                                    <a href="EliminarDetalleVenta?idDetalle=<%= codigo %>"><i class="fas fa-trash-alt"></i></a>
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
                        int IdVenta = logicaV.ObtenerUltimoId();
                        float Total = logicaV.ObtenerTotalDineroDetallesVenta(IdVenta);
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
                    <br><br>

        </div> 
                    
        <!-- Modal Buscar Productos -->
        
        <div class="modal" id="buscarProducto" tabindex="1" role="dialog" aria-labelledby="tituloVentana">
            <div class="modal-dialog" role="document" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 id="tituloVentana">Buscar Producto</h5>
                        <button class="close" data-dismiss="modal" arial-label="Cerrar" arial-hidden="true" onclick="Limpiar()">
                            <span arial-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table id="tablaProducto">
                            <thead>
                                <tr>
                                    <th>Codigo</th>
                                    <th>Nombre</th>
                                    <th>Precio</th>
                                    <th>Existencias</th>
                                    <th>Seleccionar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    LNProducto logicaP = new LNProducto();
                                    List<Producto> datoP;
                                    datoP=logicaP.ListarProducto_List("");
                                    for (Producto registros : datoP) {

                                %>
                                    <tr>
                                        <% int codigoP = registros.getIdProducto();
                                           String nombreP = registros.getDescripcion();
                                           float precioP = registros.getPrecio();
                                           float existenciasP = registros.getCantidad();
                                        %>
                                        <!-- No termina con ; potque es una exprecion -->
                                        <td><%= codigoP %></td>
                                        <td><%= nombreP %></td>
                                        <td><%= precioP %></td>
                                        <td><%= existenciasP %></td>
                                        <td>
                                            <a href="#" data-dismiss="modal"
                                               onclick="SeleccionarProducto('<%= codigoP %>', '<%= nombreP %> ', '<%= precioP %> ', '<%= existenciasP %> ')">Seleccionar</a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-warning" type="button" data-dismiss="modal" onclick="LimpiarP()">Cancelar</button>       
                    </div>
                </div>
            </div>
        </div>
                    
        <script src="lib/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
        <script src="lib/bootstrap-datepicker/locales/bootstrap-datepicker.es.min.js" type="text/javascript"></script>
        <script src="lib/DataTables/datatables.min.js" type="text/javascript"></script>
        <script src="lib/DataTables/DataTables-1.10.21/js/dataTables.bootstrap4.min.js" type="text/javascript"></script>
        
        <script src="lib/jquery-validation/dist/jquery.validate.js" type="text/javascript"></script>
        <script src="lib/jquery-validation/dist/additional-methods.js" type="text/javascript"></script>
        
        <script>
            $(document).ready(function (){
                //Mostrar calendario
                $('.datepicker').datepicker({
                    format:'yyyy-mm-dd',
                    autoclose:true,
                    language:'es'
                });
                $('#tablaProducto').dataTable({
                   "lengthMenu":[[5,10,15,-1], [5,10,15,"All"]],
                   "language": {
                       "info":"Pagina _PAGE_ de _PAGES_",
                       "infoEmpty": "No hay registros",
                       "zeroRecords":"No se encuentran registros",
                       "search":"Buscar",
                       "infoFiltered":"",
                       "lengthMenu":"Mostrar _MENU_ Registros",
                       "paginate":{
                           "first":"Primero",
                           "last":"Ultimo",
                           "next":"Siguiente",
                           "previous":"Anterior"
                           
                       }
                   }
                });
            });
            
            $(document).ready(function() {
                
                $("#form_AgregarDetalleVenta").validate({
                    rules: {
                      txtDescripcion: "required", 
                      txtCantidad: {
                        required: true, 
                        number: true 
                      }
                    },
                    messages: {
                      txtDescripcion: "Debe seleccionar un producto",
                      txtCantidad: {
                        required: "Debe ingresar una cantidad",
                        number: "La cantidad debe ser un valor numérico"
                      }
                    },
                    errorElement: 'span'
                });

                $("#btnBuscar").click(function (e) {
                    
                    $("#BtnGuardar").prop("disabled", false);

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
            function SeleccionarProducto(id, Nombre, Precio, Existencia){
                $('#txtIdProducto').val(id);
                $('#txtDescripcion').val(Nombre);

                // Habilitar los campos para establecer valores
                $('#txtPrecio').prop('disabled', false).val("₡" + Precio);
                $('#txtExistencias').prop('disabled', false).val(Existencia);

                // Deshabilitar los campos nuevamente
                $('#txtPrecio').prop('disabled', true);
                $('#txtExistencias').prop('disabled', true);
            }

        </script>
    </body>
</html>
