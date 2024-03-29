USE [Aventuras]
GO
/****** Object:  Table [dbo].[Alumnos]    Script Date: 24/07/2018 12:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Alumnos](
	[AlumnoId] [int] IDENTITY(1,1) NOT NULL,
	[NumeroControl] [varchar](6) NOT NULL,
	[NombreAlumno] [varchar](60) NOT NULL,
	[ApellidoPaterno] [varchar](60) NOT NULL,
	[ApellidoMaterno] [varchar](60) NOT NULL,
	[CorreoAlumno] [varchar](60) NOT NULL,
	[Providencia] [varchar](60) NOT NULL,
	[Calificacion] [varchar](60) NOT NULL,
	[FechaCreacion] [smalldatetime] NOT NULL,
	[FechaModificacion] [smalldatetime] NOT NULL,
	[Activo] [bit] NOT NULL,
	[Id_Materia] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AlumnoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Materias]    Script Date: 24/07/2018 12:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materias](
	[Id_Materia] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Materia] [nvarchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Materia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 24/07/2018 12:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Apellido] [nvarchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 24/07/2018 12:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[ID] [int] NOT NULL,
	[UserName] [varchar](50) NULL,
	[Apellido] [varchar](50) NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Alumnos]  WITH CHECK ADD FOREIGN KEY([Id_Materia])
REFERENCES [dbo].[Materias] ([Id_Materia])
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllAlumnos]    Script Date: 24/07/2018 12:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Israel Hernandez
-- Create date: 14/12/2017
-- Description:	Procedimiento para consultar todos los datos
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAllAlumnos] 
	AS
BEGIN
	SELECT a.AlumnoId, 
		   a.NumeroControl, 
		   a.NombreAlumno, 
		   a.ApellidoPaterno, 
		   a.ApellidoMaterno, 
		   a.CorreoAlumno, 
		   a.Providencia, 
		   a.Calificacion, 
		   m.Nombre_Materia,
		   a.Activo 
		   

	FROM Alumnos a
	INNER JOIN Materias m
	ON a.Id_Materia = m.Id_Materia
	WHERE a.Activo = 1
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCantidadAlumnosMateria]    Script Date: 24/07/2018 12:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Israel Hernandez
-- Create date: 14/12/1047
-- Description:	Procedimiento para contar el numero de alumnos que tiene las materias
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCantidadAlumnosMateria] 
AS
BEGIN
	SET NOCOUNT ON;
SELECT m.Id_Materia, m.Nombre_Materia, count(m.Nombre_Materia) as Cantida_Alumnos
FROM Alumnos a
INNER JOIN Materias m
on a.Id_Materia = m.Id_Materia
WHERE m.Activo = 1  
GROUP BY m.Nombre_Materia, m.Id_Materia
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Ins_NuevoAlumno]    Script Date: 24/07/2018 12:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Israel Hernandez
-- Create date: 15/02/2018
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_Ins_NuevoAlumno] 
	@NumeroControl VARCHAR(6), 
	@NombreAlumno VARCHAR(60),
	@ApellidoPaterno VARCHAR(60), 
	@ApellidoMaterno VARCHAR(60), 
	@CorreoAlumno VARCHAR(60), 
	@Providencia VARCHAR(60), 
	@Calificacion VARCHAR(60), 
	@Id_Materia VARCHAR(60)
  
AS
BEGIN
	SET NOCOUNT ON;
	--INSERT INTO Users(UserName,Apellido) VALUES (@UserName, @Apellido)
	INSERT INTO Alumnos(NumeroControl, 
						NombreAlumno, 
						ApellidoPaterno, 
						ApellidoMaterno, 
						CorreoAlumno, 
						Providencia, 
						Calificacion, 
						FechaCreacion, 
						FechaModificacion, 
						Activo, 
						Id_Materia)
										 
				VALUES(@NumeroControl, 
					   @NombreAlumno, 
					   @ApellidoPaterno, 
					   @ApellidoMaterno, 
					   @CorreoAlumno, 
					   @Providencia, 
					   @Calificacion,
					   GETDATE(), 
					   GETDATE(),
					   1,
					   @Id_Materia)
					   SELECT @NumeroControl as NumeroControl, 'Registro Guardado' AS Resultado


END

GO
/****** Object:  StoredProcedure [dbo].[Users_Edit]    Script Date: 24/07/2018 12:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Israel Hernandez
-- Create date: 15/02/2018
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Users_Edit] 
	
	@UserID int, 
	@UserName nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE Users set UserName = @UserName where ID = @UserID    
END

GO
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 24/07/2018 12:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Israel Hernandez
-- Create date: 15/02/2018
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Users_Insert] 
	-- Add the parameters for the stored procedure here
	@UserName nvarchar(50),
	@Apellido nvarchar(50) 
	  
AS
BEGIN
	
	SET NOCOUNT ON;
	INSERT INTO Users(UserName,Apellido) VALUES (@UserName, @Apellido)
END

GO
/****** Object:  StoredProcedure [dbo].[Users_SelectAll]    Script Date: 24/07/2018 12:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Israel Hernandez
-- Create date: 15/02/2018
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Users_SelectAll] 
	
AS
BEGIN

	SET NOCOUNT ON;

    SELECT * FROM Users
END

GO
/****** Object:  StoredProcedure [dbo].[Usp_Sel_AlumnoByNumeroControl]    Script Date: 24/07/2018 12:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_Sel_AlumnoByNumeroControl]
@NumeroControl VARCHAR(6)
AS
BEGIN
	SELECT a.AlumnoId, a.NumeroControl, a.NombreAlumno, a.ApellidoPaterno, a.ApellidoMaterno, a.CorreoAlumno, a.Providencia, a.Calificacion, a.Activo, m.Nombre_Materia  
	FROM Alumnos a with (nolock)
	INNER JOIN Materias m
	ON a.Id_Materia = m.Id_Materia
	WHERE a.NumeroControl = @NumeroControl
END
GO
