<%-- 
    Document   : frmClientes
    Created on : 31 ago. 2023, 09:19:57
    Author     : Progra
--%>
<%@page import="Entidades.Funcionario"%>
<%@page import="LogicaNegocio.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos del Funcionario</title>
        <link href="lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="lib/fontawesome-free-5.14.0-web/css/all.min.css" rel="stylesheet" type="text/css"/>
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
                <div class="col-md-6 mx-auto">
                    <div class="card-header">
                        <h1 class="text-center">Datos del Funcionario</h1>
                    </div> <br>
                    
                    <% 
                        String id = request.getParameter("idCrearModificar");
                        int codigo = Integer.parseInt(id);
                        Funcionario funcionario;
                        LNFuncionario logica = new LNFuncionario();
                        if (codigo > 0) {
                            funcionario = logica.ObtenerFuncionario("IdFuncionario = " + id);
                        }
                        else{
                            funcionario = new Funcionario();
                        }
                    %>
                    <form action="CrearModificarFuncionario" method="post" id="form_AgregarModificar">
                        <div class="form-group">
                            <%if (codigo > 0) {%>
                            
                            <!-- si existe muestra el codigo -->
                            <label for="txtCodigo" class="control-label">Codigo</label>
                            <input type="hiden" id="txtCodigo" name="txtCodigo" value="<%= funcionario.getIdFuncionario()%>" readonly class="form-control">
                            <%}else{%>
                            <input type="hidden" id="txtCodigo" name="txtCodigo" value="-1">
                            <%}%>
                        </div>
                        
                        <div>
                            <label for="txtCedula" class="control-label">Cedula</label>
                            <input type="text" id="txtCedula" name="txtCedula" value="<%= funcionario.getCedula()%>" class="form-control">
                        </div>
                        <div>
                            <label for="txtNombre" class="control-label">Nombre Completo</label>
                            <input type="text" id="txtNombre" name="txtNombre" value="<%= funcionario.getNombreCompleto()%>" class="form-control">
                        </div>
                        <div>
                            <label for="txtEdad" class="control-label">Edad</label>
                            <input type="text" id="txtEdad" name="txtEdad" value="<%= funcionario.getEdad()%>" class="form-control">
                        </div>
                        <div>
                            <label for="txtTelefono" class="control-label">Telefono</label>
                            <input type="text" id="txtTelefono" name="txtTelefono" value="<%= funcionario.getTelefono()%>" class="form-control">
                        </div>
                        <div>
                            <label for="txtDireccion" class="control-label">Direccion</label>
                            <input type="text" id="txtDireccion" name="txtDireccion" value="<%= funcionario.getDireccion()%>" class="form-control">
                        </div>
                        <div>
                            <label for="txtCorreo" class="control-label">Correo</label>
                            <input type="text" id="txtCorreo" name="txtCorreo" value="<%= funcionario.getCorreo()%>" class="form-control">
                        </div>
                        <div>
                            <label for="selOcupacion" class="control-label">Ocupación</label>
                            <select id="selOcupacion" name="selOcupacion" class="form-control">
                                <option value="Gerente" <%= funcionario.getOcupacion().equals("Administrador") ? "selected" : "" %>>Administrador</option>
                                <option value="Contador" <%= funcionario.getOcupacion().equals("Vendedor") ? "selected" : "" %>>Vendedor</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="submit" id="btnGuardar" value="Guardar" class="btn btn-primary m-2"> 
                            <input type="button" id="btnRegresar" value="Regresar" onclick="location.href='frmListarFuncionarios.jsp'" class="btn btn-secondary m-2">
                        </div>
                        
                    </form>
                </div> <!-- col-md-6 mx-auto -->
            </div> <!-- row -->
        </div> <!-- container -->
        
        <script src="lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
        <script src="lib/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <script src="lib/jquery-validation/dist/jquery.validate.js" type="text/javascript"></script>
        
        <script>
            $(document).ready(function (){
                $("#form_AgregarModificar").validate({
                    rules: {
                        txtCedula: {
                            required: true,
                            maxlength: 9
                        },
                        txtNombre: {
                            required: true,
                            maxlength: 50
                        },
                        txtEdad: {
                            required: true,
                            minlength: 1,
                            maxlength: 3
                        },
                        txtTelefono: {
                            required: true,
                            minlength: 8,
                            maxlength: 11
                        },
                        txtDireccion: {
                            required: true,
                            maxlength: 80
                        },
                        txtCorreo: {
                            required: true,
                            maxlength: 80
                        },
                        selOcupacion: {
                            required: true 
                        }
                    },
                    messages: {
                        txtCedula: "El campo cedula es obligatorio, maximo 9 caracteres",
                        txtNombre: "El campo nombre es obligatorio, maximo 50 caracteres",
                        txtEdad: "El campo edad es obligatorio, minimo 1 numero, maximo 3",
                        txtTelefono: "El campo telefono es obligatorio, minimo 8 y maximo 11 caracteres",
                        txtDireccion: "El campo direccion es obligatorio, maximo 80 caracteres",
                        txtCorreo: "El campo correo es obligatorio, maximo 80 caracteres",
                        selOcupacion: "Por favor, selecciona una ocupación"
                    },
                    errorElement: 'span'
                });
            });
        </script>

    </body>
</html>
