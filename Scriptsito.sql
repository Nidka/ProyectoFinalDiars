USE [master]
GO
/****** Object:  Database [RunaTalentoDB]    Script Date: 27/11/2025 08:05:39 p. m. ******/
CREATE DATABASE [RunaTalentoDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RunaTalentoDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\RunaTalentoDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RunaTalentoDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\RunaTalentoDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [RunaTalentoDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RunaTalentoDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RunaTalentoDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RunaTalentoDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RunaTalentoDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [RunaTalentoDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RunaTalentoDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET RECOVERY FULL 
GO
ALTER DATABASE [RunaTalentoDB] SET  MULTI_USER 
GO
ALTER DATABASE [RunaTalentoDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RunaTalentoDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RunaTalentoDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RunaTalentoDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RunaTalentoDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RunaTalentoDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'RunaTalentoDB', N'ON'
GO
ALTER DATABASE [RunaTalentoDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [RunaTalentoDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [RunaTalentoDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Actividad]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actividad](
	[IdActividad] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Puntaje] [int] NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
	[IdCurso] [int] NOT NULL,
	[ArchivoUrl] [nvarchar](255) NULL,
	[FechaLimite] [datetime2](7) NULL,
 CONSTRAINT [PK_Actividad] PRIMARY KEY CLUSTERED 
(
	[IdActividad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActividadEstudiante]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActividadEstudiante](
	[IdActividadEstudiante] [int] IDENTITY(1,1) NOT NULL,
	[IdActividad] [int] NOT NULL,
	[IdEstudiante] [nvarchar](450) NOT NULL,
	[FechaEntrega] [datetime2](7) NOT NULL,
	[PuntajeObtenido] [int] NULL,
	[UrlDocumento] [nvarchar](max) NULL,
 CONSTRAINT [PK_ActividadEstudiante] PRIMARY KEY CLUSTERED 
(
	[IdActividadEstudiante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[Nombres] [nvarchar](max) NOT NULL,
	[Apellidos] [nvarchar](max) NOT NULL,
	[FechaRegistro] [datetime2](7) NOT NULL,
	[PuntajeTotal] [int] NOT NULL,
	[Estado] [nvarchar](max) NOT NULL,
	[IdNivel] [int] NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Curso]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Curso](
	[IdCurso] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[IdDocente] [nvarchar](450) NULL,
 CONSTRAINT [PK_Curso] PRIMARY KEY CLUSTERED 
(
	[IdCurso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CursoDocente]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CursoDocente](
	[IdCursoDocente] [int] IDENTITY(1,1) NOT NULL,
	[IdCurso] [int] NOT NULL,
	[IdDocente] [nvarchar](450) NOT NULL,
	[FechaAsignacion] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CursoDocente] PRIMARY KEY CLUSTERED 
(
	[IdCursoDocente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Incentivo]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Incentivo](
	[IdIncentivo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](500) NULL,
	[PuntosRequeridos] [int] NOT NULL,
	[IconoUrl] [nvarchar](500) NULL,
	[Activo] [bit] NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Incentivo] PRIMARY KEY CLUSTERED 
(
	[IdIncentivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IncentivoEstudiante]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncentivoEstudiante](
	[IdIncentivoEstudiante] [int] IDENTITY(1,1) NOT NULL,
	[IdIncentivo] [int] NOT NULL,
	[IdEstudiante] [nvarchar](450) NOT NULL,
	[FechaOtorgado] [datetime2](7) NOT NULL,
	[PuntajeAlObtener] [int] NOT NULL,
 CONSTRAINT [PK_IncentivoEstudiante] PRIMARY KEY CLUSTERED 
(
	[IdIncentivoEstudiante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medalla]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medalla](
	[IdMedalla] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[ImagenUrl] [nvarchar](255) NULL,
 CONSTRAINT [PK_Medalla] PRIMARY KEY CLUSTERED 
(
	[IdMedalla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedallaEstudiante]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedallaEstudiante](
	[IdMedallaEstudiante] [int] IDENTITY(1,1) NOT NULL,
	[IdMedalla] [int] NOT NULL,
	[IdEstudiante] [nvarchar](450) NOT NULL,
	[FechaOtorgada] [datetime2](7) NOT NULL,
	[IdDocente] [nvarchar](450) NULL,
 CONSTRAINT [PK_MedallaEstudiante] PRIMARY KEY CLUSTERED 
(
	[IdMedallaEstudiante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nivel]    Script Date: 27/11/2025 08:05:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nivel](
	[IdNivel] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[PuntajeMinimo] [int] NOT NULL,
	[PuntajeMaximo] [int] NOT NULL,
 CONSTRAINT [PK_Nivel] PRIMARY KEY CLUSTERED 
(
	[IdNivel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Actividad_IdCurso]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Actividad_IdCurso] ON [dbo].[Actividad]
(
	[IdCurso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ActividadEstudiante_IdActividad]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_ActividadEstudiante_IdActividad] ON [dbo].[ActividadEstudiante]
(
	[IdActividad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ActividadEstudiante_IdEstudiante]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_ActividadEstudiante_IdEstudiante] ON [dbo].[ActividadEstudiante]
(
	[IdEstudiante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AspNetUsers_IdNivel]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUsers_IdNivel] ON [dbo].[AspNetUsers]
(
	[IdNivel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Curso_IdDocente]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Curso_IdDocente] ON [dbo].[Curso]
(
	[IdDocente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CursoDocente_IdCurso_IdDocente]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CursoDocente_IdCurso_IdDocente] ON [dbo].[CursoDocente]
(
	[IdCurso] ASC,
	[IdDocente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CursoDocente_IdDocente]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_CursoDocente_IdDocente] ON [dbo].[CursoDocente]
(
	[IdDocente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_IncentivoEstudiante_IdEstudiante]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_IncentivoEstudiante_IdEstudiante] ON [dbo].[IncentivoEstudiante]
(
	[IdEstudiante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_IncentivoEstudiante_IdIncentivo_IdEstudiante]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IncentivoEstudiante_IdIncentivo_IdEstudiante] ON [dbo].[IncentivoEstudiante]
(
	[IdIncentivo] ASC,
	[IdEstudiante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_MedallaEstudiante_IdDocente]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_MedallaEstudiante_IdDocente] ON [dbo].[MedallaEstudiante]
(
	[IdDocente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_MedallaEstudiante_IdEstudiante]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_MedallaEstudiante_IdEstudiante] ON [dbo].[MedallaEstudiante]
(
	[IdEstudiante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MedallaEstudiante_IdMedalla]    Script Date: 27/11/2025 08:05:40 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_MedallaEstudiante_IdMedalla] ON [dbo].[MedallaEstudiante]
(
	[IdMedalla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Actividad]  WITH CHECK ADD  CONSTRAINT [FK_Actividad_Curso_IdCurso] FOREIGN KEY([IdCurso])
REFERENCES [dbo].[Curso] ([IdCurso])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Actividad] CHECK CONSTRAINT [FK_Actividad_Curso_IdCurso]
GO
ALTER TABLE [dbo].[ActividadEstudiante]  WITH CHECK ADD  CONSTRAINT [FK_ActividadEstudiante_Actividad_IdActividad] FOREIGN KEY([IdActividad])
REFERENCES [dbo].[Actividad] ([IdActividad])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ActividadEstudiante] CHECK CONSTRAINT [FK_ActividadEstudiante_Actividad_IdActividad]
GO
ALTER TABLE [dbo].[ActividadEstudiante]  WITH CHECK ADD  CONSTRAINT [FK_ActividadEstudiante_AspNetUsers_IdEstudiante] FOREIGN KEY([IdEstudiante])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[ActividadEstudiante] CHECK CONSTRAINT [FK_ActividadEstudiante_AspNetUsers_IdEstudiante]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUsers]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUsers_Nivel_IdNivel] FOREIGN KEY([IdNivel])
REFERENCES [dbo].[Nivel] ([IdNivel])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[AspNetUsers] CHECK CONSTRAINT [FK_AspNetUsers_Nivel_IdNivel]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Curso]  WITH CHECK ADD  CONSTRAINT [FK_Curso_AspNetUsers_IdDocente] FOREIGN KEY([IdDocente])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Curso] CHECK CONSTRAINT [FK_Curso_AspNetUsers_IdDocente]
GO
ALTER TABLE [dbo].[CursoDocente]  WITH CHECK ADD  CONSTRAINT [FK_CursoDocente_AspNetUsers_IdDocente] FOREIGN KEY([IdDocente])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CursoDocente] CHECK CONSTRAINT [FK_CursoDocente_AspNetUsers_IdDocente]
GO
ALTER TABLE [dbo].[CursoDocente]  WITH CHECK ADD  CONSTRAINT [FK_CursoDocente_Curso_IdCurso] FOREIGN KEY([IdCurso])
REFERENCES [dbo].[Curso] ([IdCurso])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CursoDocente] CHECK CONSTRAINT [FK_CursoDocente_Curso_IdCurso]
GO
ALTER TABLE [dbo].[IncentivoEstudiante]  WITH CHECK ADD  CONSTRAINT [FK_IncentivoEstudiante_AspNetUsers_IdEstudiante] FOREIGN KEY([IdEstudiante])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IncentivoEstudiante] CHECK CONSTRAINT [FK_IncentivoEstudiante_AspNetUsers_IdEstudiante]
GO
ALTER TABLE [dbo].[IncentivoEstudiante]  WITH CHECK ADD  CONSTRAINT [FK_IncentivoEstudiante_Incentivo_IdIncentivo] FOREIGN KEY([IdIncentivo])
REFERENCES [dbo].[Incentivo] ([IdIncentivo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IncentivoEstudiante] CHECK CONSTRAINT [FK_IncentivoEstudiante_Incentivo_IdIncentivo]
GO
ALTER TABLE [dbo].[MedallaEstudiante]  WITH CHECK ADD  CONSTRAINT [FK_MedallaEstudiante_AspNetUsers_IdDocente] FOREIGN KEY([IdDocente])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[MedallaEstudiante] CHECK CONSTRAINT [FK_MedallaEstudiante_AspNetUsers_IdDocente]
GO
ALTER TABLE [dbo].[MedallaEstudiante]  WITH CHECK ADD  CONSTRAINT [FK_MedallaEstudiante_AspNetUsers_IdEstudiante] FOREIGN KEY([IdEstudiante])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[MedallaEstudiante] CHECK CONSTRAINT [FK_MedallaEstudiante_AspNetUsers_IdEstudiante]
GO
ALTER TABLE [dbo].[MedallaEstudiante]  WITH CHECK ADD  CONSTRAINT [FK_MedallaEstudiante_Medalla_IdMedalla] FOREIGN KEY([IdMedalla])
REFERENCES [dbo].[Medalla] ([IdMedalla])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MedallaEstudiante] CHECK CONSTRAINT [FK_MedallaEstudiante_Medalla_IdMedalla]
GO
USE [master]
GO
ALTER DATABASE [RunaTalentoDB] SET  READ_WRITE 
GO
