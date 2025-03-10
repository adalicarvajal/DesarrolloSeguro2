USE [master]
GO
/****** Object:  Database [DBPrestamo]    Script Date: 13/02/2025 23:11:02 ******/
CREATE DATABASE [DBPrestamo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBPrestamo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DBPrestamo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBPrestamo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DBPrestamo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DBPrestamo] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBPrestamo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBPrestamo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBPrestamo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBPrestamo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBPrestamo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBPrestamo] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBPrestamo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBPrestamo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBPrestamo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBPrestamo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBPrestamo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBPrestamo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBPrestamo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBPrestamo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBPrestamo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBPrestamo] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBPrestamo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBPrestamo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBPrestamo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBPrestamo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBPrestamo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBPrestamo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBPrestamo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBPrestamo] SET RECOVERY FULL 
GO
ALTER DATABASE [DBPrestamo] SET  MULTI_USER 
GO
ALTER DATABASE [DBPrestamo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBPrestamo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBPrestamo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBPrestamo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBPrestamo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBPrestamo] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DBPrestamo', N'ON'
GO
ALTER DATABASE [DBPrestamo] SET QUERY_STORE = ON
GO
ALTER DATABASE [DBPrestamo] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DBPrestamo]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- CONFIGURACION ---

create FUNCTION [dbo].[SplitString]  ( 
	@string NVARCHAR(MAX), 
	@delimiter CHAR(1)  
)
RETURNS
@output TABLE(valor NVARCHAR(MAX)  ) 
BEGIN 
	DECLARE @start INT, @end INT 
	SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
	WHILE @start < LEN(@string) + 1
	BEGIN 
		IF @end = 0  
        SET @end = LEN(@string) + 1 

		INSERT INTO @output (valor)  
		VALUES(SUBSTRING(@string, @start, @end - @start)) 
		SET @start = @end + 1 
		SET @end = CHARINDEX(@delimiter, @string, @start) 
	END 
	RETURN
END


GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[NroDocumento] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Apellido] [varchar](50) NULL,
	[Correo] [varchar](50) NULL,
	[Telefono] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Moneda]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Moneda](
	[IdMoneda] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Simbolo] [varchar](4) NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMoneda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prestamo]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prestamo](
	[IdPrestamo] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [int] NULL,
	[IdMoneda] [int] NULL,
	[FechaInicioPago] [date] NULL,
	[MontoPrestamo] [decimal](10, 2) NULL,
	[InteresPorcentaje] [decimal](10, 2) NULL,
	[NroCuotas] [int] NULL,
	[FormaDePago] [varchar](50) NULL,
	[ValorPorCuota] [decimal](10, 2) NULL,
	[ValorInteres] [decimal](10, 2) NULL,
	[ValorTotal] [decimal](10, 2) NULL,
	[Estado] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPrestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrestamoDetalle]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrestamoDetalle](
	[IdPrestamoDetalle] [int] IDENTITY(1,1) NOT NULL,
	[IdPrestamo] [int] NULL,
	[FechaPago] [date] NULL,
	[NroCuota] [int] NULL,
	[MontoCuota] [decimal](10, 2) NULL,
	[Estado] [varchar](50) NULL,
	[FechaPagado] [datetime] NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPrestamoDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[NombreCompleto] [varchar](50) NULL,
	[Correo] [varchar](50) NULL,
	[Clave] [nvarchar](60) NULL,
	[FechaCreacion] [datetime] NULL,
	[Rol] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Moneda] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Prestamo] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[PrestamoDetalle] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[PrestamoDetalle]  WITH CHECK ADD FOREIGN KEY([IdPrestamo])
REFERENCES [dbo].[Prestamo] ([IdPrestamo])
GO
/****** Object:  StoredProcedure [dbo].[sp_crearCliente]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_crearCliente](
@NroDocumento varchar(50),
@Nombre varchar(50),
@Apellido varchar(50),
@Correo varchar(50),
@Telefono varchar(50),
@msgError varchar(100) OUTPUT
)
as
begin

	set @msgError = ''
	if(not exists(select * from Cliente where 
		NroDocumento = @NroDocumento
	))
		insert into Cliente(NroDocumento,Nombre,Apellido,Correo,Telefono) values
		(@NroDocumento,@Nombre,@Apellido,@Correo,@Telefono)
	else
		set @msgError = 'El cliente ya existe'
end


GO
/****** Object:  StoredProcedure [dbo].[sp_crearMoneda]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_crearMoneda](
@Nombre varchar(50),
@Simbolo varchar(50),
@msgError varchar(100) OUTPUT
)
as
begin

	set @msgError = ''
	if(not exists(select * from Moneda where 
		Nombre = @Nombre COLLATE SQL_Latin1_General_CP1_CS_AS
	))
		insert into Moneda(Nombre,Simbolo) values(@Nombre,@Simbolo)
	else
		set @msgError = 'La moneda ya existe'
end


GO
/****** Object:  StoredProcedure [dbo].[sp_crearPrestamo]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- PROCEDIMIENTOS PARA PRESTAMOS

create procedure [dbo].[sp_crearPrestamo](
@IdCliente int,
@NroDocumento varchar(50),
@Nombre varchar(50),
@Apellido varchar(50),
@Correo varchar(50),
@Telefono varchar(50),
@IdMoneda int,
@FechaInicio varchar(50),
@MontoPrestamo varchar(50),
@InteresPorcentaje varchar(50),
@NroCuotas int,
@FormaDePago varchar(50),
@ValorPorCuota varchar(50),
@ValorInteres varchar(50),
@ValorTotal varchar(50),
@msgError varchar(100) OUTPUT
)
as
begin
	set dateformat dmy
	set @msgError = ''

	begin try

		declare @FecInicio date = convert(date,@FechaInicio)
		declare @MontPrestamo decimal(10,2) = convert(decimal(10,2),@MontoPrestamo)
		declare @IntPorcentaje decimal(10,2) = convert(decimal(10,2),@InteresPorcentaje)
		declare @VlrPorCuota decimal(10,2) = convert(decimal(10,2),@ValorPorCuota)
		declare @VlrInteres decimal(10,2) = convert(decimal(10,2),@ValorInteres)
		declare @VlrTotal decimal(10,2) = convert(decimal(10,2),@ValorTotal)
		create table #TempIdentity(Id int,Nombre varchar(10))

		begin transaction

		if(@IdCliente = 0)
		begin
			insert into Cliente(NroDocumento,Nombre,Apellido,Correo,Telefono)
			OUTPUT INSERTED.IdCliente,'Cliente' INTO #TempIdentity(Id,Nombre)
			values
			(@NroDocumento,@Nombre,@Apellido,@Correo,@Telefono)

			set @IdCliente = (select Id from #TempIdentity where Nombre = 'Cliente')
		end
		else
		begin
			if(exists(select * from Prestamo where IdCliente = @IdCliente and Estado = 'Pendiente'))
				set @msgError = 'El cliente tiene un prestamo pendiente, debe cancelar el anterior'
		end

		if(@msgError ='')
		begin

			insert into Prestamo(IdCliente,IdMoneda,FechaInicioPago,MontoPrestamo,InteresPorcentaje,NroCuotas,FormaDePago,ValorPorCuota,ValorInteres,ValorTotal,Estado)
			OUTPUT INSERTED.IdPrestamo,'Prestamo' INTO #TempIdentity(Id,Nombre)
			values
			(@IdCliente,@IdMoneda,@FecInicio,@MontPrestamo,@IntPorcentaje,@NroCuotas,@FormaDePago,@VlrPorCuota,@VlrInteres,@VlrTotal,'Pendiente')

			;with detalle(IdPrestamo,FechaPago,NroCuota,MontoCuota,Estado) as
			(
				select (select Id from #TempIdentity where Nombre = 'Prestamo'),@FecInicio,0,@VlrPorCuota,'Pendiente'
				union all
				select IdPrestamo,
				case @FormaDePago 
					when 'Diario' then DATEADD(day,1,FechaPago)
					when 'Semanal' then DATEADD(WEEK,1,FechaPago)
					when 'Quincenal' then DATEADD(day,15,FechaPago)
					when 'Mensual' then DATEADD(MONTH,1,FechaPago)
				end,
				NroCuota + 1,MontoCuota,Estado from detalle
				where NroCuota < @NroCuotas
			)
			select IdPrestamo,FechaPago,NroCuota,MontoCuota,Estado into #tempDetalle from detalle where NroCuota > 0
	
			insert into PrestamoDetalle(IdPrestamo,FechaPago,NroCuota,MontoCuota,Estado)
			select IdPrestamo,FechaPago,NroCuota,MontoCuota,Estado from #tempDetalle

		end

		commit transaction
	end try
	begin catch
		rollback transaction
		set @msgError = ERROR_MESSAGE()
	end catch
	
end


GO
/****** Object:  StoredProcedure [dbo].[sp_crearUsuario]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Crear el procedimiento almacenado con los parámetros correctos
CREATE PROCEDURE [dbo].[sp_crearUsuario]
    @NombreCompleto NVARCHAR(100),
    @Correo NVARCHAR(100),
    @Clave NVARCHAR(60),
    @Rol NVARCHAR(50)
AS
BEGIN
    INSERT INTO Usuario (NombreCompleto, Correo, Clave, FechaCreacion, Rol)
    VALUES (@NombreCompleto, @Correo, @Clave, GETDATE(), @Rol)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_editarCliente]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_editarCliente](
@IdCliente int,
@NroDocumento varchar(50),
@Nombre varchar(50),
@Apellido varchar(50),
@Correo varchar(50),
@Telefono varchar(50),
@msgError varchar(100) OUTPUT
)
as
begin

	set @msgError = ''
	if(not exists(select * from Cliente where 
		NroDocumento = @NroDocumento and IdCliente != @IdCliente
	))
		update Cliente set NroDocumento = @NroDocumento,Nombre = @Nombre,Apellido = @Apellido,Correo = @Correo,Telefono = @Telefono 
		where IdCliente = @IdCliente
	else
		set @msgError = 'El cliente ya existe'
end


GO
/****** Object:  StoredProcedure [dbo].[sp_editarMoneda]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_editarMoneda](
@IdMoneda int,
@Nombre varchar(50),
@Simbolo varchar(50),
@msgError varchar(100) OUTPUT
)
as
begin

	set @msgError = ''
	if(not exists(select * from Moneda where 
		Nombre = @Nombre COLLATE SQL_Latin1_General_CP1_CS_AS and
		IdMoneda != @IdMoneda
	))
		update Moneda set Nombre = @Nombre ,Simbolo = @Simbolo where IdMoneda = @IdMoneda
	else
		set @msgError = 'La moneda ya existe'
end


GO
/****** Object:  StoredProcedure [dbo].[sp_eliminarCliente]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_eliminarCliente](
@IdCliente int,
@msgError varchar(100) OUTPUT
)
as
begin

	set @msgError = ''
	if(not exists(select IdPrestamo from Prestamo where IdCliente = @IdCliente))
		delete from Cliente where IdCliente = @IdCliente
	else
		set @msgError = 'El cliente tiene historial de prestamo, no se puede eliminar'
end


GO
/****** Object:  StoredProcedure [dbo].[sp_eliminarMoneda]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_eliminarMoneda](
@IdMoneda int,
@msgError varchar(100) OUTPUT
)
as
begin

	set @msgError = ''
	if(not exists(select IdPrestamo from Prestamo where IdMoneda = @IdMoneda))
		delete from Moneda where IdMoneda = @IdMoneda
	else
		set @msgError = 'La moneda esta utilizada en un prestamo, no se puede eliminar'
end


GO
/****** Object:  StoredProcedure [dbo].[sp_listaCliente]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- PROCEDMIENTOS PARA CLIENTE

create procedure [dbo].[sp_listaCliente]
as
begin
	select IdCliente,NroDocumento,Nombre,Apellido,Correo,Telefono,convert(char(10),FechaCreacion,103)[FechaCreacion] from Cliente
end


GO
/****** Object:  StoredProcedure [dbo].[sp_listaMoneda]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- PROCEDMIENTOS PARA MONEDA 

create procedure [dbo].[sp_listaMoneda]
as
begin
	select IdMoneda,Nombre,Simbolo,convert(char(10),FechaCreacion,103)[FechaCreacion] from Moneda
end


GO
/****** Object:  StoredProcedure [dbo].[sp_obtenerCliente]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_obtenerCliente](
@NroDocumento varchar(50)
)
as
begin
	select IdCliente,NroDocumento,Nombre,Apellido,Correo,Telefono,convert(char(10),FechaCreacion,103)[FechaCreacion] from Cliente
	where NroDocumento = @NroDocumento
end


GO
/****** Object:  StoredProcedure [dbo].[sp_obtenerPrestamos]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_obtenerPrestamos](
@IdPrestamo int = 0,
@NroDocumento varchar(50) = ''
)as
begin
	select p.IdPrestamo,
	c.IdCliente,c.NroDocumento,c.Nombre,c.Apellido,c.Correo,c.Telefono,
	m.IdMoneda,m.Nombre[NombreMoneda],m.Simbolo,
	CONVERT(char(10),p.FechaInicioPago, 103) [FechaInicioPago],
	CONVERT(VARCHAR,p.MontoPrestamo)[MontoPrestamo],
	CONVERT(VARCHAR,p.InteresPorcentaje)[InteresPorcentaje],
	p.NroCuotas,
	p.FormaDePago,
	CONVERT(VARCHAR,p.ValorPorCuota)[ValorPorCuota],
	CONVERT(VARCHAR,p.ValorInteres)[ValorInteres],
	CONVERT(VARCHAR,p.ValorTotal)[ValorTotal],
	p.Estado,
	CONVERT(char(10),p.FechaCreacion, 103) [FechaCreacion],
	(
		select pd.IdPrestamoDetalle,CONVERT(char(10),pd.FechaPago, 103) [FechaPago],
		CONVERT(VARCHAR,pd.MontoCuota)[MontoCuota],
		pd.NroCuota,pd.Estado,isnull(CONVERT(varchar(10),pd.FechaPagado, 103),'')[FechaPagado]
		from PrestamoDetalle pd
		where pd.IdPrestamo = p.IdPrestamo
		FOR XML PATH('Detalle'), TYPE, ROOT('PrestamoDetalle')
	)
	from Prestamo p
	inner join Cliente c on c.IdCliente = p.IdCliente
	inner join Moneda m on m.IdMoneda = p.IdMoneda
	where p.IdPrestamo = iif(@IdPrestamo = 0,p.idprestamo,@IdPrestamo) and
	c.NroDocumento = iif(@NroDocumento = '',c.NroDocumento,@NroDocumento)
	FOR XML PATH('Prestamo'), ROOT('Prestamos'), TYPE;
end



GO
/****** Object:  StoredProcedure [dbo].[sp_obtenerResumen]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_obtenerResumen]
as
begin
select 
(select convert(varchar,count(*)) from Cliente) [TotalClientes],
(select convert(varchar,count(*)) from Prestamo where Estado = 'Pendiente')[PrestamosPendientes],
(select convert(varchar,count(*)) from Prestamo where Estado = 'Cancelado')[PrestamosCancelados],
(select convert(varchar,isnull(sum(ValorInteres),0)) from Prestamo where Estado = 'Cancelado')[InteresAcumulado]
end


GO
/****** Object:  StoredProcedure [dbo].[sp_obtenerUsuario]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_obtenerUsuario](
@Correo varchar(50),
@Clave varchar(50)
)
as
begin
	select IdUsuario,NombreCompleto,Correo from Usuario where 
	Correo = @Correo COLLATE SQL_Latin1_General_CP1_CS_AS and
	Clave = @Clave COLLATE SQL_Latin1_General_CP1_CS_AS
end


GO
/****** Object:  StoredProcedure [dbo].[sp_obtenerUsuarioPorCorreo]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Crear el procedimiento almacenado con los parámetros correctos
CREATE PROCEDURE [dbo].[sp_obtenerUsuarioPorCorreo]
    @Correo NVARCHAR(100)
AS
BEGIN
    SELECT IdUsuario, NombreCompleto, Correo, Clave, Rol
    FROM Usuario
    WHERE Correo = @Correo
END
GO
/****** Object:  StoredProcedure [dbo].[sp_pagarCuotas]    Script Date: 13/02/2025 23:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
create procedure [dbo].[sp_pagarCuotas](  
@IdPrestamo int,  
@NroCuotasPagadas varchar(100),  
@msgError varchar(100) OUTPUT  
)  
as  
begin  
  
 set dateformat dmy  
 set @msgError = ''  
  
 begin try  
  
  begin transaction  
  
   update pd set pd.Estado = 'Cancelado', FechaPagado = getdate() from PrestamoDetalle pd  
   inner join dbo.SplitString(@NroCuotasPagadas,',') ss on ss.valor = pd.NroCuota  
   where IdPrestamo = @IdPrestamo  
  
   if((select count(IdPrestamoDetalle) from PrestamoDetalle where IdPrestamo = @IdPrestamo and Estado='Pendiente') = 0)  
   begin  
    update Prestamo set Estado = 'Cancelado' where IdPrestamo = @IdPrestamo  
   end  
  
  
  commit transaction  
 end try  
 begin catch  
  rollback transaction  
  set @msgError = ERROR_MESSAGE()  
 end catch  
  
end  
-- PROCEDIMIENTO PARA RESUMEN


GO
USE [master]
GO
ALTER DATABASE [DBPrestamo] SET  READ_WRITE 
GO
