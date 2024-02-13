GO 
CREATE DATABASE PROYECTO_JAVA

GO
USE PROYECTO_JAVA

CREATE TABLE Funcionario (
    IdFuncionario INT IDENTITY(1,1) PRIMARY KEY,
    Ocupacion VARCHAR(100) NOT NULL,
    Cedula VARCHAR(20) NOT NULL,
    NombreCompleto VARCHAR(200) NOT NULL,
    Edad INT NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Direccion VARCHAR(200) NOT NULL,
    Correo VARCHAR(100) NOT NULL
);

CREATE TABLE Cliente (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    Cedula VARCHAR(20) NOT NULL,
    NombreCompleto VARCHAR(200) NOT NULL,
    Edad INT NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Direccion VARCHAR(200) NOT NULL,
    Correo VARCHAR(100) NOT NULL
);

CREATE TABLE Proveedores (
    IdProveedor INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(200) NOT NULL,
    NumeroContacto VARCHAR(20) NOT NULL,
    Ubicacion VARCHAR(200) NOT NULL
);

CREATE TABLE Productos (
    IdProducto INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(200) NOT NULL,
    Caducidad DATE NOT NULL,
    Categoria VARCHAR(100) NOT NULL,
    Precio FLOAT NOT NULL,
    Cantidad FLOAT NOT NULL,
	Estado VARCHAR(100) NOT NULL DEFAULT('Disponible'),
    FechaIngreso DATE NOT NULL
);

CREATE TABLE Compra (
    IdCompra INT IDENTITY(1,1) PRIMARY KEY,
    IdFuncionario INT NOT NULL,
    IdProveedor INT NOT NULL,
    PrecioTotal FLOAT,
    Fecha DATE NOT NULL,
    MetodoPago VARCHAR(50) NOT NULL
);

CREATE TABLE Venta (
    IdVenta INT IDENTITY(1,1) PRIMARY KEY,
    IdFuncionario INT NOT NULL,
    IdCliente INT NOT NULL,
    PrecioTotal FLOAT,
    Fecha DATE NOT NULL,
    MetodoPago VARCHAR(50) NOT NULL
);

CREATE TABLE DetalleCompra (
    IdDetalleCompra INT IDENTITY(1,1) PRIMARY KEY,
    IdProducto INT NOT NULL,
    IdCompra INT NOT NULL
);

CREATE TABLE DetalleVenta (
    IdDetalleVenta INT IDENTITY(1,1) PRIMARY KEY,
    IdVenta INT NOT NULL,
	Cantidad FLOAT NOT NULL,
    IdProducto INT NOT NULL
);

CREATE TABLE Bitacora (
	IdBitacora INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Fecha DATE NOT NULL,
	Hora TIME NOT NULL,
	Movimiento VARCHAR(150)
);

--Datos quemados
INSERT INTO Proveedores (Nombre, NumeroContacto, Ubicacion)
VALUES('Carnes Don Juan', '2222-5555', 'San José, Costa Rica'),
      ('Carnicería La Familia', '8888-1234', 'Heredia, Costa Rica'),
      ('Carnes El Rodeo', '7777-9876', 'Alajuela, Costa Rica');


--Relaciones
ALTER TABLE Compra
    ADD CONSTRAINT FK_Funcionario_Compra FOREIGN KEY (IdFuncionario)
    REFERENCES Funcionario(IdFuncionario)

ALTER TABLE Compra
    ADD CONSTRAINT FK_Proveedor_Compra FOREIGN KEY (IdProveedor)
    REFERENCES Proveedores(IdProveedor)

ALTER TABLE Venta
    ADD CONSTRAINT FK_Funcionario_Venta FOREIGN KEY (IdFuncionario)
    REFERENCES Funcionario(IdFuncionario)

ALTER TABLE Venta
    ADD CONSTRAINT FK_Cliente_Venta FOREIGN KEY (IdCliente)
    REFERENCES Cliente(IdCliente)

ALTER TABLE DetalleCompra
    ADD CONSTRAINT FK_Compra_DetalleCompra FOREIGN KEY (IdCompra)
    REFERENCES Compra(IdCompra)

ALTER TABLE DetalleCompra
    ADD CONSTRAINT FK_Producto_DetalleCompra FOREIGN KEY (IdProducto)
    REFERENCES Productos(IdProducto)

ALTER TABLE DetalleVenta
    ADD CONSTRAINT FK_Producto_DetalleVenta FOREIGN KEY (IdProducto)
    REFERENCES Productos(IdProducto)

ALTER TABLE DetalleVenta
    ADD CONSTRAINT FK_Venta_DetalleVenta FOREIGN KEY (IdVenta)
    REFERENCES Venta(IdVenta)

--Procedimientos almacenados
GO
CREATE OR ALTER PROCEDURE spEliminarClienteConValidacion
    @IdCliente INT,
    @Mensaje NVARCHAR(MAX) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Venta WHERE IdCliente = @IdCliente)
    BEGIN
        DELETE FROM Cliente WHERE IdCliente = @IdCliente;
        SET @Mensaje = 'Cliente eliminado correctamente.';
    END
    ELSE
    BEGIN
        SET @Mensaje = 'No se puede eliminar el cliente. Tiene facturas asignadas.';
    END
END;

--Eliminar Producto
GO
CREATE OR ALTER PROCEDURE sp_DeleteProducto
    @IdProducto INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    DECLARE @CantidadDetalles INT;

    -- Verificar si el producto tiene detalles asignados
    SELECT @CantidadDetalles = COUNT(*) FROM DetalleVenta WHERE IdProducto = @IdProducto;

    IF @CantidadDetalles = 0
    BEGIN
        -- Eliminar el producto
        DELETE FROM Productos WHERE IdProducto = @IdProducto;

        SET @Mensaje = 'Producto eliminado exitosamente.';
    END
    ELSE
    BEGIN
        SET @Mensaje = 'No se puede eliminar el producto porque tiene detalles asignados.';
    END;
END;

--Insertar un cliente
GO
CREATE OR ALTER PROCEDURE sp_InsertarCliente
    @ClienteId INT,
    @Cedula VARCHAR(20),
    @NombreCompleto VARCHAR(200),
    @Edad INT,
    @Telefono VARCHAR(20),
    @Direccion VARCHAR(200),
    @Correo VARCHAR(100),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    -- Verificar si el ClienteId ya está registrado
    DECLARE @ExisteCliente INT;
    SELECT @ExisteCliente = COUNT(*) FROM Cliente WHERE IdCliente = @ClienteId;

    IF @ExisteCliente > 0
    BEGIN
        -- Actualizar el cliente existente
        UPDATE Cliente
        SET 
            Cedula = @Cedula,
            NombreCompleto = @NombreCompleto,
            Edad = @Edad,
            Telefono = @Telefono,
            Direccion = @Direccion,
            Correo = @Correo
        WHERE IdCliente = @ClienteId;

        SET @Mensaje = 'Cliente modificado exitosamente.';
    END
    ELSE
    BEGIN
        -- Verificar si la cédula ya está registrada para otros clientes
        DECLARE @ExisteCedula INT;
        SELECT @ExisteCedula = COUNT(*) FROM Cliente WHERE Cedula = @Cedula;

        IF @ExisteCedula > 0
        BEGIN
            SET @Mensaje = 'Ya existe un cliente con la misma cedula.';
        END
        ELSE
        BEGIN
            -- Insertar el nuevo cliente
            INSERT INTO Cliente (Cedula, NombreCompleto, Edad, Telefono, Direccion, Correo)
            VALUES (@Cedula, @NombreCompleto, @Edad, @Telefono, @Direccion, @Correo);

            SET @Mensaje = 'Cliente insertado exitosamente.';
        END;
    END;
END;


--Insertar un funcionario
GO
CREATE OR ALTER PROCEDURE sp_InsertarFuncionario
    @FuncionarioId INT,
    @Ocupacion VARCHAR(100),
    @Cedula VARCHAR(20),
    @NombreCompleto VARCHAR(200),
    @Edad INT,
    @Telefono VARCHAR(20),
    @Direccion VARCHAR(200),
    @Correo VARCHAR(100),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    -- Verificar si el FuncionarioId ya está registrado
    DECLARE @ExisteFuncionario INT;
    SELECT @ExisteFuncionario = COUNT(*) FROM Funcionario WHERE IdFuncionario = @FuncionarioId;

    IF @ExisteFuncionario > 0
    BEGIN
        -- Actualizar el funcionario existente
        UPDATE Funcionario
        SET 
            Ocupacion = @Ocupacion,
            Cedula = @Cedula,
            NombreCompleto = @NombreCompleto,
            Edad = @Edad,
            Telefono = @Telefono,
            Direccion = @Direccion,
            Correo = @Correo
        WHERE IdFuncionario = @FuncionarioId;

        SET @Mensaje = 'Funcionario modificado exitosamente.';
    END
    ELSE
    BEGIN
        -- Verificar si la cédula ya está registrada para otros funcionarios
        DECLARE @ExisteCedula INT;
        SELECT @ExisteCedula = COUNT(*) FROM Funcionario WHERE Cedula = @Cedula;

        IF @ExisteCedula > 0
        BEGIN
            SET @Mensaje = 'Ya existe un funcionario con la misma cedula.';
        END
        ELSE
        BEGIN
            -- Insertar el nuevo funcionario
            INSERT INTO Funcionario (Ocupacion, Cedula, NombreCompleto, Edad, Telefono, Direccion, Correo)
            VALUES (@Ocupacion, @Cedula, @NombreCompleto, @Edad, @Telefono, @Direccion, @Correo);

            SET @Mensaje = 'Funcionario insertado exitosamente.';
        END;
    END;
END;


--Insertar un proveedor
GO
CREATE OR ALTER PROCEDURE sp_InsertarProveedor
    @Nombre VARCHAR(200),
    @NumeroContacto VARCHAR(20),
    @Ubicacion VARCHAR(200),
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    DECLARE @ExisteProveedor INT;

    -- Verificar si el proveedor con el mismo nombre y número de contacto ya está registrado
    SELECT @ExisteProveedor = COUNT(*) FROM Proveedores WHERE Nombre = @Nombre AND NumeroContacto = @NumeroContacto;

    IF @ExisteProveedor > 0
    BEGIN
        SET @Mensaje = 'Ya existe un proveedor con el mismo nombre y número de contacto.';
    END
    ELSE
    BEGIN
        -- Insertar el nuevo proveedor
        INSERT INTO Proveedores (Nombre, NumeroContacto, Ubicacion)
        VALUES (@Nombre, @NumeroContacto, @Ubicacion);

        SET @Mensaje = 'Proveedor insertado exitosamente.';
    END;
END;


--Eliminar un funcionario
GO
CREATE OR ALTER PROCEDURE spEliminarFuncionarioConValidacion
    @IdFuncionario INT,
    @Mensaje NVARCHAR(MAX) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Venta WHERE IdFuncionario = @IdFuncionario)
        AND NOT EXISTS (SELECT 1 FROM Compra WHERE IdFuncionario = @IdFuncionario)
    BEGIN
        DELETE FROM Funcionario WHERE IdFuncionario = @IdFuncionario;
        SET @Mensaje = 'Funcionario eliminado correctamente.';
    END
    ELSE
    BEGIN
        SET @Mensaje = 'No se puede eliminar el funcionario. Tiene facturas asignadas.';
    END
END;

--Eliminar un proveedor
GO
CREATE OR ALTER PROCEDURE sp_EliminarProveedor
    @IdProveedor INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN

    IF EXISTS (SELECT 1 FROM Compra WHERE IdProveedor = @IdProveedor)
    BEGIN
        SET @Mensaje = 'No se puede eliminar el proveedor porque tiene facturas de compras asignadas.';
    END
    ELSE
    BEGIN
        DELETE FROM Proveedores WHERE IdProveedor = @IdProveedor;
        SET @Mensaje = 'Proveedor eliminado exitosamente.';
    END
END;

--Agregar un detalle compra y el producto
GO
CREATE OR ALTER PROCEDURE sp_CrearProductoYAgregarDetalle
    @Descripcion VARCHAR(200),
    @Caducidad DATE,
    @Categoria VARCHAR(100),
    @Precio FLOAT,
    @Cantidad FLOAT,
    @IdFactura INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    DECLARE @NuevoIdProducto INT;

    -- Verificar si ya existe un producto con el mismo nombre y categoría
    DECLARE @ProductoExistenteId INT;
    SELECT @ProductoExistenteId = IdProducto
    FROM Productos
    WHERE Descripcion = @Descripcion AND Categoria = @Categoria;

    -- Si ya existe, aumentar la cantidad y obtener el ID del producto existente
    IF @ProductoExistenteId IS NOT NULL
    BEGIN
        UPDATE Productos
        SET Cantidad = Cantidad + @Cantidad
        WHERE IdProducto = @ProductoExistenteId;

        SET @NuevoIdProducto = @ProductoExistenteId;
        SET @Mensaje = 'Cantidad del producto existente aumentada exitosamente.';
    END
    ELSE
    BEGIN
		DECLARE @FechaIngreso DATE;
		SET @FechaIngreso = GETDATE();
        -- Crear el producto
        INSERT INTO Productos (Descripcion, Caducidad, Categoria, Precio, Cantidad, FechaIngreso)
        VALUES (@Descripcion, @Caducidad, @Categoria, @Precio, @Cantidad, @FechaIngreso);

        -- Obtener el ID del producto recién creado
        SET @NuevoIdProducto = SCOPE_IDENTITY();

        -- Agregar el producto como detalle a la factura
        INSERT INTO DetalleCompra (IdProducto, IdCompra)
        VALUES (@NuevoIdProducto, @IdFactura);

        SET @Mensaje = 'Producto creado y agregado al detalle de compra exitosamente.';
    END;
END;
--Crear un factura y obtener el id 
GO
CREATE OR ALTER PROCEDURE sp_CrearFactura
    @IdFuncionario INT,
    @IdProveedor INT,
    @MetodoPago VARCHAR(50),
    @IdFactura INT OUTPUT
AS
BEGIN
    DECLARE @FechaActual DATE = GETDATE();

    INSERT INTO Compra (IdFuncionario, IdProveedor, MetodoPago, Fecha)
    VALUES (@IdFuncionario, @IdProveedor, @MetodoPago, @FechaActual);

    SET @IdFactura = SCOPE_IDENTITY();
END;

--Obtener ultima id creada de la factura
GO
CREATE OR ALTER PROCEDURE ObtenerIdConUltimaCompra
    @parametro INT OUTPUT
AS
BEGIN
    DECLARE @ultimaIdCompra INT;

    -- Obtener la última ID de compra
    SELECT @ultimaIdCompra = MAX(IdCompra) FROM Compra;

    -- Sumar el parámetro con la última ID de compra
    SET @parametro = @ultimaIdCompra;

END;

--Obtener ultima id creada de la venta
GO
CREATE OR ALTER PROCEDURE ObtenerIdConUltimaVenta
    @parametro INT OUTPUT
AS
BEGIN
    DECLARE @ultimaIdVenta INT;

    -- Obtener la última ID de compra
    SELECT @ultimaIdVenta = MAX(IdVenta) FROM Venta;

    -- Sumar el parámetro con la última ID de compra
    SET @parametro = @ultimaIdVenta;

END;

--Crear Factura Compra web
GO
CREATE OR ALTER PROCEDURE sp_CrearFacturaCompraWeb
    @IdFuncionario INT,
    @IdProveedor INT,
    @MetodoPago VARCHAR(50),
    @IdFactura INT OUTPUT
AS
BEGIN
    DECLARE @FechaActual DATE = GETDATE();

    INSERT INTO Compra (IdFuncionario, IdProveedor, MetodoPago, Fecha)
    VALUES (@IdFuncionario, @IdProveedor, @MetodoPago, @FechaActual);

    SET @IdFactura = SCOPE_IDENTITY();
END;

--Crear factura de venta 
GO
CREATE OR ALTER PROCEDURE sp_CrearFacturaVenta
    @IdFuncionario INT,
    @IdCliente INT,
    @MetodoPago VARCHAR(50),
    @IdFactura INT OUTPUT
AS
BEGIN
    DECLARE @FechaActual DATE = GETDATE();

    INSERT INTO Venta (IdFuncionario, IdCliente, Fecha, MetodoPago)
    VALUES (@IdFuncionario, @IdCliente, @FechaActual, @MetodoPago);

    SET @IdFactura = SCOPE_IDENTITY();
END;

--Agregar detalle de venta
GO
CREATE OR ALTER PROCEDURE sp_AgregarDetalleVenta
    @IdVenta INT,
    @Cantidad FLOAT,
    @IdProducto INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    DECLARE @CantidadDisponible FLOAT;
    DECLARE @DetalleExistente INT;

    -- Obtener la cantidad disponible del producto
    SELECT @CantidadDisponible = Cantidad FROM Productos WHERE IdProducto = @IdProducto;

    -- Verificar si el producto ya existe en algún detalle de la misma factura
    SELECT @DetalleExistente = IdDetalleVenta FROM DetalleVenta WHERE IdVenta = @IdVenta AND IdProducto = @IdProducto;

    IF @DetalleExistente IS NOT NULL
    BEGIN
        -- Verificar si hay suficientes existencias para agregar la cantidad adicional
        IF @Cantidad <= @CantidadDisponible
        BEGIN
            -- Actualizar la cantidad en el detalle existente
            UPDATE DetalleVenta
            SET Cantidad = Cantidad + @Cantidad
            WHERE IdDetalleVenta = @DetalleExistente;

            -- Actualizar la cantidad del producto
            UPDATE Productos
            SET Cantidad = Cantidad - @Cantidad
            WHERE IdProducto = @IdProducto;

            SET @Mensaje = 'Cantidad del producto actualizada en el detalle existente.';
        END
        ELSE
        BEGIN
            SET @Mensaje = 'No hay suficiente cantidad disponible para agregar al detalle existente.';
        END;
    END
    ELSE
    BEGIN
        -- Verificar si la cantidad a vender es menor o igual que la cantidad disponible
        IF @Cantidad <= @CantidadDisponible
        BEGIN
            -- Insertar el detalle de venta
            INSERT INTO DetalleVenta (IdVenta, Cantidad, IdProducto)
            VALUES (@IdVenta, @Cantidad, @IdProducto);

            -- Actualizar la cantidad del producto
            UPDATE Productos
            SET Cantidad = Cantidad - @Cantidad
            WHERE IdProducto = @IdProducto;

            SET @Mensaje = 'Detalle de venta agregado exitosamente.';
        END
        ELSE
        BEGIN
            SET @Mensaje = 'No hay suficiente cantidad disponible para la venta.';
        END;
    END;
END;

--Trigger 
GO
CREATE OR ALTER TRIGGER trg_ActualizarCantidadProducto
ON DetalleVenta
AFTER DELETE
AS
BEGIN
    DECLARE @IdDetalleVenta INT;
    DECLARE @CantidadEliminada FLOAT;
    DECLARE @IdProducto INT;

    -- Obtener los datos del detalle eliminado
    SELECT @IdDetalleVenta = deleted.IdDetalleVenta,
           @CantidadEliminada = deleted.Cantidad,
           @IdProducto = deleted.IdProducto
    FROM deleted;

    -- Actualizar la cantidad en la tabla Productos
    UPDATE Productos
    SET Cantidad = Cantidad + @CantidadEliminada
    WHERE IdProducto = @IdProducto;
END;

GO
CREATE OR ALTER TRIGGER trg_ActualizarPrecioTotalVenta
ON DetalleVenta
AFTER INSERT
AS
BEGIN
    DECLARE @IdVenta INT;

    -- Obtener el IdVenta del detalle recién insertado
    SELECT @IdVenta = IdVenta FROM inserted;

    -- Actualizar el PrecioTotal de la venta
    UPDATE Venta
    SET PrecioTotal = (
        SELECT SUM(p.Precio * dv.Cantidad) AS TotalDinero
        FROM DetalleVenta dv
        INNER JOIN Productos p ON dv.IdProducto = p.IdProducto
        WHERE dv.IdVenta = @IdVenta
    )
    WHERE IdVenta = @IdVenta;
END;


GO
CREATE OR ALTER TRIGGER trg_ActualizarPrecioTotal
ON DetalleCompra
AFTER INSERT
AS
BEGIN
    DECLARE @IdCompra INT;

    -- Obtener el IdCompra del detalle recién insertado
    SELECT @IdCompra = IdCompra FROM inserted;

    -- Actualizar el PrecioTotal de la factura
    UPDATE Compra
    SET PrecioTotal = (
        SELECT SUM(p.Precio * p.Cantidad) AS TotalDinero
        FROM DetalleCompra dc
        INNER JOIN Productos p ON dc.IdProducto = p.IdProducto
        WHERE dc.IdCompra = @IdCompra
    )
    WHERE IdCompra = @IdCompra;
END;

--Eliminar detalle y producto asociado a el
GO
CREATE OR ALTER PROCEDURE sp_EliminarDetalleCompraConProducto
    @IdDetalleCompra INT,
    @Mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @IdProducto INT;

    -- Obtener el IdProducto del detalle de compra a eliminar
    SELECT @IdProducto = IdProducto FROM DetalleCompra WHERE IdDetalleCompra = @IdDetalleCompra;

    -- Eliminar el detalle de compra
    DELETE FROM DetalleCompra WHERE IdDetalleCompra = @IdDetalleCompra;

    -- Verificar si el producto está relacionado con otros detalles de compra
    IF NOT EXISTS (SELECT 1 FROM DetalleCompra WHERE IdProducto = @IdProducto)
    BEGIN
        -- Si no está relacionado con otros detalles de compra, eliminar el producto
        DELETE FROM Productos WHERE IdProducto = @IdProducto;
    END;

    IF @@ERROR = 0
    BEGIN
        COMMIT;
        SET @Mensaje = 'Detalle de compra y producto eliminados exitosamente.';
    END
    ELSE
    BEGIN
        ROLLBACK;
        SET @Mensaje = 'Error al intentar eliminar el detalle de compra y/o producto.';
    END;
END;

--Trigger que cambia el estado a Caducido cuando la fecha de caducidad el igual o menor a la fecha actual 
GO
CREATE OR ALTER TRIGGER tr_ActualizarEstadoProducto
ON Productos
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Hoy DATE = GETDATE();

    -- Actualizar el estado de los productos caducados
    UPDATE Productos
    SET Estado = 'Caducado'
    WHERE Caducidad <= @Hoy;
END;


