-- Script para agregar las columnas faltantes ArchivoUrl y UrlDocumento
-- Ejecuta este script en tu base de datos RunaTalentoDB

USE RunaTalentoDB;
GO

-- Verificar y agregar columna ArchivoUrl a la tabla Actividad
IF NOT EXISTS (
    SELECT * FROM sys.columns 
    WHERE object_id = OBJECT_ID(N'[dbo].[Actividad]') 
    AND name = 'ArchivoUrl'
)
BEGIN
    ALTER TABLE [dbo].[Actividad]
    ADD [ArchivoUrl] NVARCHAR(255) NULL;
    PRINT 'Columna ArchivoUrl agregada a la tabla Actividad';
END
ELSE
BEGIN
    PRINT 'La columna ArchivoUrl ya existe en la tabla Actividad';
END
GO

-- Verificar y agregar columna UrlDocumento a la tabla ActividadEstudiante
IF NOT EXISTS (
    SELECT * FROM sys.columns 
    WHERE object_id = OBJECT_ID(N'[dbo].[ActividadEstudiante]') 
AND name = 'UrlDocumento'
)
BEGIN
    ALTER TABLE [dbo].[ActividadEstudiante]
    ADD [UrlDocumento] NVARCHAR(MAX) NULL;
    PRINT 'Columna UrlDocumento agregada a la tabla ActividadEstudiante';
END
ELSE
BEGIN
    PRINT 'La columna UrlDocumento ya existe en la tabla ActividadEstudiante';
END
GO

-- Registrar la migración en __EFMigrationsHistory
IF NOT EXISTS (
  SELECT * FROM [dbo].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20251201000000_AgregarColumnasArchivos'
)
BEGIN
    INSERT INTO [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20251201000000_AgregarColumnasArchivos', N'8.0.11');
    PRINT 'Migración registrada en __EFMigrationsHistory';
END
GO

PRINT 'Script ejecutado exitosamente. Las columnas han sido agregadas.';
