# ?? GUÍA DE USO - PATRONES IMPLEMENTADOS

## ?? INTRODUCCIÓN

Esta guía te enseñará cómo usar los 6 patrones de diseño implementados en RunaTalento:
- 4 Patrones GoF (Gang of Four)
- 2 Principios GRASP

---

## ?? INICIO RÁPIDO

### 1. Compilar el Proyecto
```bash
cd "C:\Users\Piero\Desktop\DIARS (1)\ProyectoFinalDiars\RunaTalento"
dotnet build
```

### 2. Ejecutar la Aplicación
```bash
dotnet run
```

### 3. Abrir en Navegador
```
https://localhost:5001
```

---

## 1?? USAR PATRÓN STRATEGY

### ¿Qué hace?
Permite elegir entre 3 estrategias de calificación:
- **Estándar**: Puntaje sin modificaciones
- **Bonificación**: +10% si se entregó a tiempo
- **Penalización**: -20% si se entregó tarde

### Cómo usarlo:

#### Paso 1: Iniciar sesión como Docente
```
Usuario: admin@runatalento.com
Contraseña: Admin123!
```

#### Paso 2: Navegar a Calificar Actividades
```
Menú ? Calificar Actividades
```

#### Paso 3: Seleccionar Estrategia
En cada actividad verás un selector:
```
???????????????????????????????????????
? Puntaje: [80]  [Calificar]         ?
?                                     ?
? Estrategia:                         ?
? [?? Estándar            ?]         ?
?  ?? Con Bonificación (+10%)        ?
?  ?? Con Penalización (-20%)        ?
???????????????????????????????????????
```

#### Paso 4: Calificar
- Ingresa el puntaje (ej: 80)
- Selecciona estrategia (ej: Bonificación)
- Clic en "Calificar"

#### Resultado:
```
? Puntaje bonificado: 80 + 8 = 88 puntos (Entrega puntual)
```

### Código Interno:
```csharp
// En DocenteController.cs
var strategy = _strategyFactory.CrearEstrategia(estrategiaCalificacion);
var resultado = controladorCalificacion.ProcesarCalificacion(
    actividadEstudiante, puntajeObtenido, fechaLimite);
```

---

## 2?? USAR PATRÓN FACTORY METHOD

### ¿Qué hace?
Crea automáticamente la estrategia correcta sin usar `if-else`.

### Cómo funciona internamente:
```csharp
// Automático en cada calificación
var factory = new CalificacionStrategyFactory();

// Usuario selecciona "bonificacion"
var strategy = factory.CrearEstrategia("bonificacion");
// ? Retorna CalificacionConBonificacionStrategy

// Usuario selecciona "penalizacion"  
var strategy = factory.CrearEstrategia("penalizacion");
// ? Retorna CalificacionConPenalizacionStrategy
```

### Beneficio:
No necesitas modificar código para agregar nuevas estrategias, solo:
1. Crear clase que implemente `ICalificacionStrategy`
2. Agregar case en el Factory
3. ¡Listo! La nueva estrategia está disponible

---

## 3?? USAR PATRÓN OBSERVER

### ¿Qué hace?
Notifica automáticamente cuando se califica una actividad.

### Cómo funciona:

#### Actualmente Implementado:
Cuando calificas una actividad, se registra en los logs:

```
[15:30:42] info: Actividad calificada - Estudiante: abc123, Actividad: 5, Puntaje: 88
```

#### Ver los Logs:
En Visual Studio:
```
Ver ? Salida ? Seleccionar "Depuración"
```

O en la terminal donde ejecutas `dotnet run`.

### Agregar Nuevo Observador (Ejemplo: Email):

#### Paso 1: Crear clase
```csharp
// En Services/Observers/EmailNotificationObserver.cs
public class EmailNotificationObserver : ICalificacionObserver
{
    private readonly IEmailService _emailService;
    
    public EmailNotificationObserver(IEmailService emailService)
    {
        _emailService = emailService;
    }
    
    public void OnActividadCalificada(string estudianteId, int actividadId, int puntaje)
    {
        _emailService.Enviar(
            estudianteId, 
            "Tu actividad ha sido calificada", 
            $"Obtuviste {puntaje} puntos"
        );
    }
}
```

#### Paso 2: Registrar en Program.cs
```csharp
builder.Services.AddScoped<ICalificacionObserver, EmailNotificationObserver>();
```

#### Paso 3: ¡Listo!
Ahora cada calificación envía un email automáticamente.

---

## 4?? USAR PATRÓN DECORATOR

### ¿Qué hace?
Añade modificadores a las actividades que aumentan el puntaje:
- **Dificultad "difícil"**: +20%
- **Dificultad "muy_difícil"**: +35%
- **Urgente** (< 2 días): +15%

### Cómo usarlo:

#### Como Docente - Crear Actividad con Modificadores:

##### Paso 1: Crear Actividad Normal
```
Menú ? Crear Actividad
Título: Proyecto Final
Puntaje: 100
Curso: Programación
```

##### Paso 2: Agregar en Base de Datos
Para usar decoradores, actualiza la actividad en la BD:
```sql
UPDATE Actividad 
SET NivelDificultad = 'muy_dificil',
    FechaLimite = DATEADD(day, 1, GETDATE())
WHERE IdActividad = 1;
```

O en código:
```csharp
actividad.NivelDificultad = "muy_dificil";
actividad.FechaLimite = DateTime.Now.AddDays(1);
```

#### Como Estudiante - Ver Actividad con Modificadores:

##### Navegar a la Actividad:
```
Menú ? Mis Actividades ? Realizar
```

##### Verás:
```
???????????????????????????????????????????????
? ???? MUY DIFÍCIL - ? URGENTE               ?
? Proyecto Final                              ?
?                                             ?
? Puntaje Especial:                           ?
? Esta actividad otorga 100? 155 puntos      ?
?                                             ?
? ? Bonificación por urgencia: +15%         ?
? ?? Bonificación por dificultad: +35%       ?
?                                             ?
? Fecha límite: 23/12/2024 14:30             ?
? Quedan 1 días                               ?
???????????????????????????????????????????????
```

### Cálculo Automático:
```
Puntaje Base:        100 pts
Dificultad (+35%):  +35 pts
Urgencia (+15%):    +20 pts
Total:               155 pts
```

---

## 5?? USAR PRINCIPIO CONTROLLER (GRASP)

### ¿Qué hace?
Separa la lógica de negocio de los controladores MVC.

### Beneficio:
El código es más limpio y reutilizable.

### Antes (Sin Patrón):
```csharp
// DocenteController.cs - TODO en un método
public async Task<IActionResult> Calificar(int id, int puntaje)
{
    // Validación
    if (puntaje < 0) return BadRequest();
    
    // Cálculo de puntaje
    var entregadoATiempo = actividad.FechaEntrega <= actividad.FechaLimite;
    var puntajeFinal = entregadoATiempo ? puntaje * 1.1 : puntaje * 0.8;
    
    // Actualizar estudiante
    estudiante.PuntajeTotal += puntajeFinal;
    
    // Calcular nivel
    var nuevoNivel = _context.Nivel.Where(...).FirstOrDefault();
    
    // Otorgar incentivos
    var incentivos = await OtorgarIncentivos(estudiante);
    
    // Guardar
    await _context.SaveChangesAsync();
    
    // Todo mezclado en 100+ líneas ??
}
```

### Después (Con Patrón CONTROLLER):
```csharp
// DocenteController.cs - Solo coordinación
public async Task<IActionResult> Calificar(int id, int puntaje, string estrategia)
{
    var resultado = _calificacionController.ProcesarCalificacion(...);
    var actualizacion = await _gamificacionService.ActualizarPuntajeYNivel(...);
    var incentivos = await _gamificacionService.OtorgarIncentivosAutomaticos(...);
    
    return View(resultado);
    // Solo 5 líneas limpias ??
}
```

### Uso:
No necesitas hacer nada especial, el patrón funciona automáticamente.
Beneficio: Código más fácil de probar y mantener.

---

## 6?? USAR PRINCIPIO HIGH COHESION (GRASP)

### ¿Qué hace?
Agrupa responsabilidades relacionadas en servicios especializados.

### Servicios Creados:

#### 1. CalificacionBusinessController
Responsabilidad: Procesar calificaciones
```csharp
var resultado = _calificacionController.ProcesarCalificacion(
    actividadEstudiante, 
    puntajeAsignado, 
    fechaLimite
);
```

#### 2. GamificacionService
Responsabilidad: Manejo de puntos, niveles e incentivos
```csharp
// Actualizar puntaje y nivel
var actualizacion = await _gamificacionService.ActualizarPuntajeYNivel(
    estudianteId, 
    puntosGanados
);

// Otorgar incentivos
var incentivos = await _gamificacionService.OtorgarIncentivosAutomaticos(
    estudianteId
);

// Obtener estadísticas
var stats = await _gamificacionService.ObtenerEstadisticas(
    estudianteId
);
```

### Beneficio:
Cada servicio hace UNA cosa y la hace bien.

---

## ?? PROBAR LOS PATRONES

### Test 1: Strategy Pattern
1. Login como docente
2. Ir a "Calificar Actividades"
3. Calificar con "Estándar" ? Puntaje = 80
4. Calificar otra con "Bonificación" ? Puntaje = 88 (si entregó a tiempo)
5. Calificar otra con "Penalización" ? Puntaje = 64 (si entregó tarde)

**? Éxito:** Mensajes muestran cálculos diferentes

---

### Test 2: Factory Pattern
1. Cambiar entre estrategias
2. Verificar que cada una calcula diferente

**? Éxito:** Sin errores al cambiar estrategias

---

### Test 3: Observer Pattern
1. Calificar cualquier actividad
2. Ver logs en consola/output

**? Éxito:** Log muestra: "Actividad calificada - Estudiante: xxx"

---

### Test 4: Decorator Pattern
1. Actualizar actividad en BD con dificultad "muy_dificil"
2. Login como estudiante
3. Ver actividad

**? Éxito:** Muestra puntaje aumentado y etiquetas de modificadores

---

### Test 5: Controller GRASP
1. Calificar actividad
2. Verificar que estudiante sube de nivel automáticamente

**? Éxito:** Mensaje muestra: "Subiste de nivel: Bronce ? Plata"

---

### Test 6: High Cohesion GRASP
1. Calificar actividad
2. Verificar que se otorgan incentivos automáticamente

**? Éxito:** Mensaje muestra: "Incentivos obtenidos: Medalla de Oro"

---

## ?? EXTENDER LOS PATRONES

### Agregar Nueva Estrategia de Calificación:

#### Paso 1: Crear clase
```csharp
// Services/Strategies/CalificacionPorExcelenciaStrategy.cs
public class CalificacionPorExcelenciaStrategy : ICalificacionStrategy
{
    public string NombreEstrategia => "Calificación por Excelencia";

    public int CalcularPuntaje(int puntajeMaximo, int puntajeObtenido, bool entregadoATiempo)
    {
        // Si obtiene más del 90%, bonificación del 25%
        if (puntajeObtenido >= puntajeMaximo * 0.9)
        {
            return (int)(puntajeObtenido * 1.25);
        }
        return puntajeObtenido;
    }
}
```

#### Paso 2: Registrar en Factory
```csharp
// Services/Factories/CalificacionStrategyFactory.cs
public ICalificacionStrategy CrearEstrategia(string tipoEstrategia)
{
    return tipoEstrategia?.ToLower() switch
    {
        "bonificacion" => new CalificacionConBonificacionStrategy(),
        "penalizacion" => new CalificacionConPenalizacionStrategy(),
        "excelencia" => new CalificacionPorExcelenciaStrategy(), // ? NUEVO
        _ => new CalificacionEstandarStrategy()
    };
}
```

#### Paso 3: Agregar a la vista
```html
<!-- Views/Docente/CalificarActividades.cshtml -->
<select name="estrategiaCalificacion">
    <option value="estandar">?? Estándar</option>
    <option value="bonificacion">?? Con Bonificación (+10%)</option>
    <option value="penalizacion">?? Con Penalización (-20%)</option>
    <option value="excelencia">? Por Excelencia (+25%)</option> <!-- NUEVO -->
</select>
```

#### ¡Listo! ??

---

## ?? RECURSOS ADICIONALES

### Documentación:
- `PATRONES_IMPLEMENTADOS.md` - Documentación técnica completa
- `VERIFICACION_COMPILACION.md` - Estado de compilación
- `RESUMEN_EJECUTIVO.md` - Resumen visual

### Archivos Clave:
```
Services/
??? Strategies/          # Patrón Strategy
??? Factories/           # Patrón Factory Method
??? Observers/           # Patrón Observer
??? Decorators/          # Patrón Decorator
??? Controllers/         # Principio Controller (GRASP)
??? GamificacionService/ # Principio High Cohesion (GRASP)
```

---

## ? PREGUNTAS FRECUENTES

### ¿Puedo usar múltiples estrategias en la misma calificación?
No, solo una estrategia por calificación. Pero puedes combinar decoradores en las actividades.

### ¿Cómo sé qué estrategia usar?
- **Estándar**: Para calificaciones normales
- **Bonificación**: Para motivar entregas tempranas
- **Penalización**: Para desincentivar entregas tardías

### ¿Los decoradores se acumulan?
Sí, si una actividad es "muy_difícil" (+35%) Y "urgente" (+15%), el estudiante obtiene ambos bonos.

### ¿Puedo desactivar un decorador?
Sí:
- Para urgencia: Quita la fecha límite o ponla > 2 días
- Para dificultad: Cambia `NivelDificultad` a "normal"

### ¿Los observadores afectan el rendimiento?
No significativamente. El `LogCalificacionObserver` es muy ligero. Observadores futuros (email, analytics) se ejecutan en background.

---

## ?? CONCLUSIÓN

Los patrones implementados hacen que RunaTalento sea:
- ? **Extensible**: Fácil agregar nuevas funcionalidades
- ? **Mantenible**: Código organizado y limpio
- ? **Testeable**: Lógica separada de la UI
- ? **Profesional**: Sigue mejores prácticas de la industria

---

**¿Necesitas ayuda?**
Revisa la documentación completa en `PATRONES_IMPLEMENTADOS.md`

**¡Disfruta usando los patrones! ??**
