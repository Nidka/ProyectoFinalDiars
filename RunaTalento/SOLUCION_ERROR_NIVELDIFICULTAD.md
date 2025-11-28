# ?? SOLUCIÓN AL ERROR: Invalid column name 'NivelDificultad'

## ? PROBLEMA

```
SqlException: Invalid column name 'NivelDificultad'.
```

La columna `NivelDificultad` no existe en la tabla `Actividad` de la base de datos.

---

## ? SOLUCIÓN

### **Opción 1: Ejecutar SQL Manualmente (RECOMENDADO - Más Rápido)**

#### Paso 1: Abrir SQL Server Management Studio (SSMS)
1. Abrir SSMS
2. Conectar al servidor: `localhost`
3. Seleccionar base de datos: `RunaTalentoDB`

#### Paso 2: Ejecutar el Script SQL
1. Abrir el archivo: `RunaTalento/Migrations/AgregarNivelDificultad_Manual.sql`
2. Copiar todo el contenido
3. Pegar en una nueva ventana de consulta en SSMS
4. Ejecutar (F5 o botón "Ejecutar")

#### Resultado Esperado:
```
Columna NivelDificultad agregada exitosamente
Migración registrada en historial
```

---

### **Opción 2: Ejecutar SQL desde Visual Studio**

#### Paso 1: Abrir SQL Server Object Explorer
1. En Visual Studio: Ver ? SQL Server Object Explorer
2. Expandir: (localdb)\MSSQLLocalDB ? Databases ? RunaTalentoDB

#### Paso 2: Nueva Consulta
1. Click derecho en `RunaTalentoDB` ? New Query
2. Pegar el contenido de `AgregarNivelDificultad_Manual.sql`
3. Ejecutar

---

### **Opción 3: Usando sqlcmd (Línea de Comandos)**

```bash
sqlcmd -S localhost -d RunaTalentoDB -E -i "RunaTalento\Migrations\AgregarNivelDificultad_Manual.sql"
```

---

### **Opción 4: Sincronizar Historial de Migraciones y Aplicar**

Si prefieres usar Entity Framework Migrations:

#### Paso 1: Marcar las migraciones existentes como aplicadas

Ejecuta este SQL para sincronizar el historial:

```sql
-- Marcar migraciones existentes como aplicadas
IF NOT EXISTS (SELECT * FROM __EFMigrationsHistory WHERE MigrationId = '20251102184958_InitialCreate')
BEGIN
    INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion)
    VALUES ('20251102184958_InitialCreate', '8.0.0');
END

IF NOT EXISTS (SELECT * FROM __EFMigrationsHistory WHERE MigrationId = '20251121000009_AgregarFechaLimiteActividad')
BEGIN
    INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion)
    VALUES ('20251121000009_AgregarFechaLimiteActividad', '8.0.0');
END
```

#### Paso 2: Aplicar la nueva migración

```bash
cd "C:\Users\Piero\Desktop\DIARS (1)\ProyectoFinalDiars\RunaTalento"
dotnet ef database update
```

---

## ?? VERIFICAR QUE LA SOLUCIÓN FUNCIONÓ

### Método 1: SQL Query
Ejecuta en SSMS:

```sql
-- Verificar que la columna existe
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Actividad' 
AND COLUMN_NAME = 'NivelDificultad';

-- Debe retornar:
-- COLUMN_NAME        DATA_TYPE    CHARACTER_MAXIMUM_LENGTH
-- NivelDificultad    nvarchar     20
```

### Método 2: Verificar en la Aplicación
1. Ejecutar la aplicación: `dotnet run`
2. Navegar a cualquier vista que use actividades
3. Si NO aparece el error, la solución funcionó ?

---

## ?? SCRIPT SQL COMPLETO

```sql
-- Script para agregar la columna NivelDificultad a la tabla Actividad

-- Verificar si la columna ya existe
IF NOT EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'Actividad' 
    AND COLUMN_NAME = 'NivelDificultad'
)
BEGIN
    -- Agregar la columna NivelDificultad
    ALTER TABLE Actividad
    ADD NivelDificultad NVARCHAR(20) NULL;
    
    -- Establecer valor por defecto "normal" para registros existentes
    UPDATE Actividad
    SET NivelDificultad = 'normal'
    WHERE NivelDificultad IS NULL;
    
    PRINT 'Columna NivelDificultad agregada exitosamente';
END
ELSE
BEGIN
    PRINT 'La columna NivelDificultad ya existe';
END
GO

-- Actualizar el historial de migraciones si es necesario
IF NOT EXISTS (
    SELECT * FROM __EFMigrationsHistory 
    WHERE MigrationId = '20251128021435_AgregarNivelDificultadActividad'
)
BEGIN
    INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion)
    VALUES ('20251128021435_AgregarNivelDificultadActividad', '8.0.0');
    
    PRINT 'Migración registrada en historial';
END
ELSE
BEGIN
    PRINT 'Migración ya está registrada';
END
GO
```

---

## ?? RESUMEN

**Causa del error:** El modelo `Actividad.cs` tiene la propiedad `NivelDificultad`, pero la columna no existe en la base de datos.

**Solución:** Ejecutar el script SQL para agregar la columna y registrar la migración en el historial.

**Tiempo estimado:** 2 minutos

---

## ?? IMPORTANTE

Este script es **idempotente**, lo que significa que:
- ? Puede ejecutarse múltiples veces sin causar errores
- ? Verifica si la columna ya existe antes de agregarla
- ? Verifica si la migración ya está registrada

---

## ?? SI EL PROBLEMA PERSISTE

1. Verifica la conexión a la base de datos en `appsettings.json`:
   ```json
   "ConnectionStrings": {
     "DefaultConnection": "Server=localhost;Database=RunaTalentoDB;Trusted_Connection=True;TrustServerCertificate=True;"
   }
   ```

2. Confirma que la base de datos existe:
   ```sql
   SELECT name FROM sys.databases WHERE name = 'RunaTalentoDB';
   ```

3. Verifica permisos de usuario para modificar la base de datos

---

**Archivo SQL:** `RunaTalento/Migrations/AgregarNivelDificultad_Manual.sql`  
**Fecha:** Diciembre 2024  
**Estado:** ? Script validado y listo para ejecutar
