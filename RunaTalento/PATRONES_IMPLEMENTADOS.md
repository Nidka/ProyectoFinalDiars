# ?? DOCUMENTACIÓN DE PATRONES IMPLEMENTADOS

## Proyecto: RunaTalento - Sistema de Gamificación Académica

### ? PATRONES GoF IMPLEMENTADOS (4)

---

## 1?? STRATEGY (Estrategia) - GoF Comportamiento

### **Ubicación:**
- `Services/Strategies/ICalificacionStrategy.cs`
- `Services/Strategies/CalificacionEstandarStrategy.cs`
- `Services/Strategies/CalificacionConBonificacionStrategy.cs`
- `Services/Strategies/CalificacionConPenalizacionStrategy.cs`

### **Propósito:**
Permite intercambiar dinámicamente el algoritmo de calificación sin modificar el código cliente.

### **Implementación:**
- **Interfaz:** `ICalificacionStrategy` define el contrato común
- **Estrategias concretas:**
  - `CalificacionEstandarStrategy`: Puntaje sin modificaciones
  - `CalificacionConBonificacionStrategy`: +10% si se entregó a tiempo
  - `CalificacionConPenalizacionStrategy`: -20% si se entregó tarde

### **Uso en el código:**
```csharp
// En DocenteController.cs - Método Calificar
var strategy = _strategyFactory.CrearEstrategia(estrategiaCalificacion);
var resultado = controladorCalificacion.ProcesarCalificacion(
    actividadEstudiante, puntajeObtenido, fechaLimite);
```

### **Beneficios:**
- ? Fácil agregar nuevas estrategias de calificación
- ? Cambio dinámico de algoritmo en tiempo de ejecución
- ? Código abierto a extensión, cerrado a modificación (SOLID)

---

## 2?? FACTORY METHOD (Método Fábrica) - GoF Creacional

### **Ubicación:**
- `Services/Factories/CalificacionStrategyFactory.cs`

### **Propósito:**
Centraliza la creación de objetos de estrategias de calificación, encapsulando la lógica de instanciación.

### **Implementación:**
```csharp
public class CalificacionStrategyFactory : ICalificacionStrategyFactory
{
    public ICalificacionStrategy CrearEstrategia(string tipoEstrategia)
    {
        return tipoEstrategia?.ToLower() switch
        {
            "bonificacion" => new CalificacionConBonificacionStrategy(),
            "penalizacion" => new CalificacionConPenalizacionStrategy(),
            _ => new CalificacionEstandarStrategy()
        };
    }
}
```

### **Uso en el código:**
```csharp
// Registrado en Program.cs
builder.Services.AddScoped<ICalificacionStrategyFactory, CalificacionStrategyFactory>();

// Usado en DocenteController
var strategy = _strategyFactory.CrearEstrategia("bonificacion");
```

### **Beneficios:**
- ? Desacopla la creación de objetos del uso
- ? Centraliza la lógica de instanciación
- ? Facilita testing con mock factories

---

## 3?? OBSERVER (Observador) - GoF Comportamiento

### **Ubicación:**
- `Services/Observers/ICalificacionObserver.cs`
- `Services/Observers/CalificacionNotifier.cs`
- `Services/Observers/LogCalificacionObserver.cs`

### **Propósito:**
Notifica a múltiples componentes cuando se califica una actividad, permitiendo reacciones automáticas.

### **Implementación:**
```csharp
// Sujeto Observable
public class CalificacionNotifier
{
    private readonly List<ICalificacionObserver> _observers = new();

    public void Attach(ICalificacionObserver observer) { ... }
    public void NotificarCalificacion(string estudianteId, int actividadId, int puntaje) 
    {
        foreach (var observer in _observers)
            observer.OnActividadCalificada(estudianteId, actividadId, puntaje);
    }
}

// Observador Concreto
public class LogCalificacionObserver : ICalificacionObserver
{
    public void OnActividadCalificada(string estudianteId, int actividadId, int puntaje)
    {
        _logger.LogInformation("Actividad calificada - Estudiante: {0}, Puntaje: {1}", 
            estudianteId, puntaje);
    }
}
```

### **Uso en el código:**
```csharp
// En CalificacionBusinessController
_notifier.NotificarCalificacion(estudianteId, actividadId, puntajeFinal);
```

### **Beneficios:**
- ? Desacopla la lógica de calificación de las notificaciones
- ? Fácil agregar nuevos observadores (analytics, emails, etc.)
- ? Permite reacciones automáticas a eventos

### **Posibles extensiones:**
- `EmailNotificationObserver`: Enviar emails al estudiante
- `AnalyticsObserver`: Registrar métricas en sistema de analytics
- `BadgeObserver`: Otorgar insignias automáticamente

---

## 4?? DECORATOR (Decorador) - GoF Estructural

### **Ubicación:**
- `Services/Decorators/IActividadComponent.cs`
- `Services/Decorators/ActividadBase.cs`
- `Services/Decorators/ActividadDecorator.cs`
- `Services/Decorators/ActividadUrgenciaDecorator.cs`
- `Services/Decorators/ActividadDificultadDecorator.cs`
- `Models/Actividad.cs` (propiedades calculadas)

### **Propósito:**
Añade funcionalidades adicionales a las actividades dinámicamente (bonificaciones por dificultad y urgencia).

### **Implementación:**
```csharp
// En Actividad.cs
[NotMapped]
public int PuntajeConModificadores
{
    get
    {
        var puntaje = Puntaje;
        
        // Decorador de Dificultad
        if (NivelDificultad == "dificil")
            puntaje = (int)(puntaje * 1.20); // +20%
        
        // Decorador de Urgencia
        if (EsUrgente)
            puntaje = (int)(puntaje * 1.15); // +15%
        
        return puntaje;
    }
}
```

### **Uso en el código:**
```csharp
// En Realizar.cshtml
<strong>@Model.PuntajeConModificadores puntos</strong>
<h4>@Model.DescripcionConModificadores</h4>
```

### **Beneficios:**
- ? Añade funcionalidades sin modificar la clase original
- ? Combinación flexible de modificadores
- ? Código extensible para nuevos tipos de bonificaciones

---

## ? PRINCIPIOS GRASP IMPLEMENTADOS (2)

---

## 5?? CONTROLLER (Controlador) - GRASP

### **Ubicación:**
- `Services/Controllers/CalificacionBusinessController.cs`

### **Propósito:**
Delega operaciones de sistema a un objeto especializado que coordina y controla el flujo, separando la lógica de negocio de la UI.

### **Implementación:**
```csharp
public class CalificacionBusinessController
{
    private readonly ICalificacionStrategy _strategy;
    private readonly CalificacionNotifier _notifier;

    public ResultadoCalificacion ProcesarCalificacion(
        ActividadEstudiante actividadEstudiante,
        int puntajeAsignado,
        DateTime? fechaLimite)
    {
        // 1. Validar datos
        // 2. Aplicar estrategia de calificación
        // 3. Actualizar modelo
        // 4. Notificar observadores
        // 5. Retornar resultado
    }
}
```

### **Uso en el código:**
```csharp
// En DocenteController (MVC Controller - UI)
var resultado = _calificacionController.ProcesarCalificacion(
    actividadEstudiante, puntajeObtenido, fechaLimite);
```

### **Beneficios:**
- ? Separa lógica de negocio de controladores MVC
- ? Código reutilizable en diferentes contextos (API, Jobs, etc.)
- ? Facilita testing unitario
- ? Cumple Single Responsibility Principle (SRP)

---

## 6?? HIGH COHESION (Alta Cohesión) - GRASP

### **Ubicación:**
- `Services/GamificacionService/GamificacionService.cs`

### **Propósito:**
Mantiene responsabilidades relacionadas juntas en clases especializadas, evitando que controladores tengan múltiples responsabilidades mezcladas.

### **Implementación:**
```csharp
public class GamificacionService
{
    // ? TODA la lógica de gamificación está aquí
    public async Task<ActualizacionGamificacion> ActualizarPuntajeYNivel(...)
    public async Task<List<string>> OtorgarIncentivosAutomaticos(...)
    public async Task<EstadisticasEstudiante> ObtenerEstadisticas(...)
}

// Clases de datos cohesivas
public class ActualizacionGamificacion { /* solo datos de actualización */ }
public class EstadisticasEstudiante { /* solo estadísticas */ }
public class ResultadoCalificacion { /* solo resultado */ }
```

### **Antes (Baja Cohesión):**
```csharp
// DocenteController tenía TODA esta lógica mezclada:
public async Task<IActionResult> Calificar(...)
{
    // Validación de entrada
    // Cálculo de puntaje
    // Actualización de nivel
    // Otorgamiento de incentivos
    // Manejo de errores
    // Generación de mensajes
    // ...todo mezclado con lógica de UI
}
```

### **Después (Alta Cohesión):**
```csharp
// DocenteController solo coordina servicios:
public async Task<IActionResult> Calificar(...)
{
    var resultado = _calificacionController.ProcesarCalificacion(...);
    var actualizacion = await _gamificacionService.ActualizarPuntajeYNivel(...);
    var incentivos = await _gamificacionService.OtorgarIncentivosAutomaticos(...);
    return View(resultado);
}
```

### **Beneficios:**
- ? Código organizado y fácil de mantener
- ? Cada clase tiene una responsabilidad clara
- ? Fácil encontrar dónde modificar funcionalidad
- ? Reduce acoplamiento entre componentes
- ? Facilita testing individual de cada servicio

---

## ?? RESUMEN DE MEJORAS

### **Antes:**
- ? DocenteController con 300+ líneas mezclando responsabilidades
- ? Lógica de calificación hardcodeada
- ? Imposible cambiar algoritmos dinámicamente
- ? Sin notificaciones de eventos
- ? Sin modificadores de actividades

### **Después:**
- ? Código modular separado en servicios especializados
- ? 4 estrategias de calificación intercambiables
- ? Sistema de notificaciones extensible
- ? Actividades con modificadores dinámicos
- ? Fácil agregar nuevas funcionalidades
- ? Testing unitario simplificado

---

## ?? CÓMO USAR LOS PATRONES

### **1. Cambiar Estrategia de Calificación:**
```csharp
// En la vista CalificarActividades.cshtml
<select name="estrategiaCalificacion">
    <option value="estandar">Estándar</option>
    <option value="bonificacion">Con Bonificación</option>
    <option value="penalizacion">Con Penalización</option>
</select>
```

### **2. Agregar Nueva Estrategia:**
```csharp
// Crear nueva clase
public class CalificacionExcelenciaStrategy : ICalificacionStrategy
{
    public int CalcularPuntaje(int max, int obtenido, bool aTiempo)
    {
        return obtenido >= max * 0.9 ? (int)(obtenido * 1.25) : obtenido;
    }
}

// Registrar en Factory
case "excelencia": return new CalificacionExcelenciaStrategy();
```

### **3. Agregar Nuevo Observador:**
```csharp
public class EmailObserver : ICalificacionObserver
{
    public void OnActividadCalificada(string estudianteId, int actividadId, int puntaje)
    {
        // Enviar email al estudiante
    }
}

// Registrar en Program.cs
builder.Services.AddScoped<ICalificacionObserver, EmailObserver>();
```

### **4. Aplicar Decoradores a Actividades:**
```csharp
// Al crear/editar actividad
actividad.NivelDificultad = "muy_dificil"; // +35% puntaje
// Si FechaLimite es < 2 días, automáticamente EsUrgente = true (+15%)
```

---

## ?? TESTING

### **Test de Strategy:**
```csharp
[Fact]
public void CalificacionConBonificacion_DebeAgregar10Porciento()
{
    var strategy = new CalificacionConBonificacionStrategy();
    var resultado = strategy.CalcularPuntaje(100, 80, true);
    Assert.Equal(88, resultado); // 80 + 10% = 88
}
```

### **Test de Controller (GRASP):**
```csharp
[Fact]
public void ProcesarCalificacion_DebeNotificarObservadores()
{
    var mockObserver = new Mock<ICalificacionObserver>();
    var notifier = new CalificacionNotifier();
    notifier.Attach(mockObserver.Object);
    
    var controller = new CalificacionBusinessController(strategy, notifier);
    controller.ProcesarCalificacion(actividad, 80, null);
    
    mockObserver.Verify(o => o.OnActividadCalificada(It.IsAny<string>(), It.IsAny<int>(), 80), Times.Once);
}
```

---

## ?? EXTENSIBILIDAD FUTURA

### **Fácil agregar:**
1. ? Nuevas estrategias de calificación (rúbricas, peer-review, etc.)
2. ? Observadores para analytics, webhooks, notifications push
3. ? Decoradores para bonificaciones por horario, cantidad de intentos
4. ? Servicios especializados (ReportesService, NotificacionesService)

---

## ?? CONCLUSIÓN

Los patrones implementados transformaron el código de RunaTalento de un monolito rígido a un sistema modular, extensible y mantenible, siguiendo las mejores prácticas de diseño de software.

**Autor:** Implementación de Patrones GoF y GRASP  
**Fecha:** 2024  
**Proyecto:** RunaTalento - Plataforma de Gamificación Académica
