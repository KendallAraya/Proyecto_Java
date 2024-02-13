<%-- 
    Document   : FrmFacturar
    Created on : 1 sep. 2023, 08:46:56
    Author     : Progra
--%>
<%@page import="LogicaNegocio.LNFacturaCompra"%>
<%@page import="Entidades.Producto"%>
<%@page import="Entidades.Compra"%>
<%@page import="Entidades.Funcionario" %>
<%@page import="LogicaNegocio.LNFuncionario" %>
<%@page import="Entidades.Proveedor" %>
<%@page import="LogicaNegocio.LNProveedor" %>
<%@page import="java.util.List" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Factura de Compra</title>
        <link href="lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/bootstrap-datepicker/css/bootstrap-datepicker3.standalone.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/fontawesome-free-5.14.0-web/css/all.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/DataTables/datatables.min.css" rel="stylesheet" type="text/css"/>
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
            <div class="row">
                <div class="col-10"><h1 class="text-center">Facturacion de Compras</h1></div>
            </div>
            <br>
            <% 
                Compra compra = new Compra();
            %>
            <form action="FacturarCompra" method="post" id="form_AgregarCompra">
                <div id="FacturaCompra">
                    <div class="form-group float-right">
                        <div class="input-group">
                            <label for="txtNumFactura">Num Factura</label>
                            <input type="text" id="txtNumFactura" name="txtNumFactura" value="<%= compra.getIdCompra()%>" class="form-control" readonly>
                        </div>
                        
                        <div class="input-group">
                            <label for="txtFechaFactura">Fecha Factura</label>
                            <input type="text" id="txtFechaFactura" name="txtFechaFactura" value="<%= compra.getFecha()%>" required class="datepicker form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <input type="hidden" id="txtIdFuncionario" name="txtIdFuncionario" value="<%= compra.getIdFuncionario()%>" class="form-control" placeholder="ID. Funcionario" readonly>
                            <input type="text" id="txtNombreFuncionario" name="txtNombreFuncionario" value="" class="form-control" placeholder="Seleccione un Funcionario" readonly>
                            <a id="btnBuscarFuncionario" class="btn btn-success btnBuscar" data-toggle="modal" data-target="#buscarFuncionario">
                                <li class="fas fa-search"></li>
                            </a>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <input type="hidden" id="txtIdProveedor" name="txtIdProveedor" value="<%= compra.getIdProveedor()%>" class="form-control" placeholder="ID. Proveedor" readonly>
                            <input type="text" id="txtNombreProveedor" name="txtNombreProveedor" value="" class="form-control" placeholder="Seleccione un Proveedor" readonly>
                            <a id="btnBuscarProveedor" class="btn btn-success btnBuscar" data-toggle="modal" data-target="#buscarProveedor">
                                <li class="fas fa-search"></li>
                            </a>
                        </div>
                    </div>
                    <div>
                        <label for="selMetodoPago" class="control-label">Metodo de Pago</label>
                        <select id="selMetodoPago" name="selMetodoPago" class="form-control">
                            <option value="Efectivo" <%= compra.getMetodoPago().equals("Efectivo") ? "selected" : "" %>>Efectivo</option>
                            <option value="Tarjeta" <%= compra.getMetodoPago().equals("Tarjeta") ? "selected" : "" %>>Tarjeta</option>
                            <option value="Transaccion" <%= compra.getMetodoPago().equals("Transaccion") ? "selected" : "" %>>Transaccion</option>
                            <option value="SINPE" <%= compra.getMetodoPago().equals("SINPE") ? "selected" : "" %>>SINPE</option>
                        </select>
                    </div>
                </div>
                <hr>
                <div class="form-group">
                    <input type="submit" id="BtnAgregarProducto" name="Agregar" value="Agregar Productos" class="btn btn-primary" disabled>
                </div>
            </form>
            <br><br>
        </div> <!-- Container -->

        
        <!-----------------------------------------Modales------------------------------------------------->
        
        <!-- Modal Buscar Funcionarios -->
        
        <div class="modal" id="buscarFuncionario" tabindex="1" role="dialog" aria-labelledby="tituloVentana">
            <div class="modal-dialog" role="document" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 id="tituloVentana">Buscar Funcionario</h5>
                        <button class="close" data-dismiss="modal" arial-label="Cerrar" arial-hidden="true" onclick="Limpiar()">
                            <span arial-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table id="tablaFuncionarios">
                            <thead>
                                <tr>
                                    <th>Codigo</th>
                                    <th>Nombre</th>
                                    <th>Seleccionar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    LNFuncionario logicaF = new LNFuncionario();
                                    List<Funcionario> datoF;
                                    datoF=logicaF.ListarFuncionario_List("");
                                    for (Funcionario registros : datoF) {

                                %>
                                    <tr>
                                        <% int codigoF = registros.getIdFuncionario();
                                           String nombreF = registros.getNombreCompleto();
                                        %>
                                        <!-- No termina con ; potque es una exprecion -->
                                        <td><%= codigoF %></td>
                                        <td><%= nombreF %></td>
                                        <td>
                                            <a href="#" data-dismiss="modal"
                                               onclick="SeleccionarCliente('<%= codigoF %>', '<%= nombreF %> ')">Seleccionar</a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-warning" type="button" data-dismiss="modal" onclick="Limpiar()">Cancelar</button>       
                    </div>
                </div>
            </div>
        </div>
                                
        <!-- Modal Buscar Proveedor -->
        
        <div class="modal" id="buscarProveedor" tabindex="1" role="dialog" aria-labelledby="tituloVentana">
            <div class="modal-dialog" role="document" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 id="tituloVentana">Buscar Proveedor</h5>
                        <button class="close" data-dismiss="modal" arial-label="Cerrar" arial-hidden="true" onclick="Limpiar()">
                            <span arial-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table id="tablaProveedores">
                            <thead>
                                <tr>
                                    <th>Codigo</th>
                                    <th>Nombre</th>
                                    <th>Seleccionar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    LNProveedor logicaP = new LNProveedor();
                                    List<Proveedor> datoP;
                                    datoP=logicaP.ListarProveedor_List("");
                                    for (Proveedor registros : datoP) {

                                %>
                                    <tr>
                                        <% int codigoP = registros.getIdProveedor();
                                           String nombreP = registros.getNombre();
                                        %>
                                        <!-- No termina con ; potque es una exprecion -->
                                        <td><%= codigoP %></td>
                                        <td><%= nombreP %></td>
                                        <td>
                                            <a href="#" data-dismiss="modal"
                                               onclick="SeleccionarProveedor('<%= codigoP %>', '<%= nombreP %> ')">Seleccionar</a>
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
                $('#tablaFuncionarios').dataTable({
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
                
                $('#tablaProveedores').dataTable({
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
            //Seleccionar Cliente 
            function SeleccionarCliente(idFuncionario, Nombre){
                $('#txtIdFuncionario').val(idFuncionario);
                $('#txtNombreFuncionario').val(Nombre);
                VerificarSeleccion();
            }
            
            function Limpiar(){
                $('#txtIdFuncionario').val("");
                $('#txtNombreFuncionario').val("");
            }
            
            function SeleccionarProveedor(IdProveedor, Nombre){
                $('#txtIdProveedor').val(IdProveedor);
                $('#txtNombreProveedor').val(Nombre);
                VerificarSeleccion();
            }
            
            function LimpiarP(){
                $('#txtIdProveedor').val("");
                $('#txtNombreProveedor').val("");
            }
            
            function VerificarSeleccion() {
                var nombreFuncionario = $("#txtNombreFuncionario").val();
                var nombreProveedor = $("#txtIdProveedor").val();

                // Si ambos campos tienen valores seleccionados, habilita el botón
                if (nombreFuncionario !== "" && nombreProveedor !== "") {
                    $("#BtnAgregarProducto").prop("disabled", false);
                } else {
                    $("#BtnAgregarProducto").prop("disabled", true);
                }
            }
            
            $(document).ready(function() {
                // Cuando se haga clic en el botón "Agregar Productos"
                $("#BtnAgregarProducto").click(function (e) {

                    $.ajax({
                        type: "POST",  // O el método que corresponda
                        url: "FacturarCompra",  // URL del servlet
                        data: $("#form_AgregarCompra").serialize(),  // Datos del formulario serializados
                        success: function (response) {
                            // Manejar la respuesta del servlet aquí
                            console.log("Solicitud enviada con éxito");
                            
                            // Limpiar "null" si está presente y establecer el valor en el campo
                            var facturaId = response.replace("null", "");

                            // Redirigir o realizar otras acciones según la respuesta
                            // Por ejemplo, puedes usar facturaId para mostrar el ID en tu página
                            console.log(facturaId);
                            $("#txtNumFactura").val(facturaId);
                        },
                        error: function (error) {
                            // Manejar errores aquí
                            console.error("Error al enviar la solicitud al servlet");
                            console.error(error);
                        }
                    });
                    window.location.href = "frmDetalleCompra.jsp";
                    
                    e.preventDefault();

                });

                
            });

        </script>
    </body>
</html>
