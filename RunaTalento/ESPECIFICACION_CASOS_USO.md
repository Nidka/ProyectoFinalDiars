# ?? ESPECIFICACIÓN DE CASOS DE USO - RunaTalento

## ?? DESCRIPCIÓN DEL SISTEMA

**Nombre del Proyecto:** RunaTalento  
**Versión:** 1.0  
**Framework:** .NET 8.0 (ASP.NET Core MVC)  
**Base de Datos:** SQL Server  
**Patrones Implementados:** 4 GoF + 2 GRASP  

---

## ?? RESUMEN EJECUTIVO

RunaTalento es una plataforma de **gamificación académica** que permite a docentes:
- Crear actividades y calificarlas con diferentes estrategias
- Otorgar medallas e incentivos a estudiantes
- Ver rankings y desempeño de estudiantes

Y a estudiantes:
- Realizar actividades y ver su progreso
- Acumular puntos y subir de nivel
- Obtener medallas e incentivos

---

## ?? ACTORES DEL SISTEMA

```
????????????????????????????????????????????????????????????
?                    ACTORES PRINCIPALES                    ?
????????????????????????????????????????????????????????????
? 1. ADMINISTRADOR                                         ?
?    ?? Gestiona usuarios (docentes y estudiantes)         ?
?    ?? Crea y edita niveles de gamificación               ?
?    ?? Crea y edita medallas                              ?
?    ?? Crea y edita incentivos                            ?
?    ?? Crea y asigna cursos a docentes                    ?
?                                                           ?
? 2. DOCENTE                                               ?
?    ?? Crea actividades en sus cursos                     ?
?    ?? Califica actividades de estudiantes                ?
?    ?? Otorga medallas a estudiantes                      ?
?    ?? Ve ranking de desempeño                            ?
?    ?? Usa estrategias de calificación                    ?
?                                                           ?
? 3. ESTUDIANTE                                            ?
?    ?? Realiza (entrega) actividades                      ?
?    ?? Ve su progreso en gamificación                     ?
?    ?? Ve sus puntos y nivel actual                       ?
?    ?? Recibe medallas e incentivos                       ?
?    ?? Ve ranking de compañeros                           ?
????????????????????????????????????????????????????????????
```

---

## ?? CASOS DE USO DETALLADOS

### 1?? GESTIÓN DE USUARIOS (Administrador)

#### CU-001: Crear Usuario (Docente o Estudiante)
```
Actores:          Administrador
Precondiciones:   Administrador autenticado
Flujo Principal:
  1. Acceder a "Gestionar Usuarios"
  2. Clic en "Nuevo Usuario"
  3. Completar formulario:
     - Email (único)
     - Nombre y Apellidos
     - Rol (Docente / Estudiante)
     - Contraseña
  4. Guardar
  5. Sistema envía confirmación de registro
  
Postcondiciones:  Usuario creado y activado
Excepciones:      
  - Email ya existe ? Mostrar error
  - Campos vacíos ? Validar formulario
  
Patrón usado:     Identity (ASP.NET Core)
```

#### CU-002: Editar Usuario
```
Actores:          Administrador
Precondiciones:   Usuario existe
Flujo Principal:
  1. Seleccionar usuario de lista
  2. Clic en "Editar"
  3. Modificar datos permitidos:
     - Nombre y Apellidos
     - Estado (Activo/Inactivo)
  4. Guardar cambios
  
Postcondiciones:  Usuario actualizado
```

#### CU-003: Activar/Desactivar Usuario
```
Actores:          Administrador
Precondiciones:   Usuario existe
Flujo Principal:
  1. Ver lista de usuarios
  2. Clic en "Activar" o "Desactivar"
  3. Confirmar acción
  
Postcondiciones:  Estado de usuario cambiado
Restricciones:    No se puede desactivar al último admin
```

---

### 2?? GESTIÓN DE CURSOS (Administrador)

#### CU-004: Crear Curso
```
Actores:          Administrador
Precondiciones:   Administrador autenticado
Flujo Principal:
  1. Acceder a "Gestionar Cursos"
  2. Clic en "Nuevo Curso"
  3. Completar:
     - Nombre del curso
     - Descripción
     - Semestre
     - Año
  4. Guardar
  
Postcondiciones:  Curso creado
```

#### CU-005: Asignar Docentes a Curso
```
Actores:          Administrador
Precondiciones:   Curso existe, hay docentes disponibles
Flujo Principal:
  1. Seleccionar curso
  2. Clic en "Asignar Docentes"
  3. Seleccionar docentes de lista
  4. Guardar asignaciones
  
Postcondiciones:  Docentes asignados al curso
Notas:            Un docente puede enseñar en múltiples cursos
```

---

### 3?? GESTIÓN DE NIVELES (Administrador)

#### CU-006: Crear Nivel de Gamificación
```
Actores:          Administrador
Precondiciones:   Administrador autenticado
Flujo Principal:
  1. Acceder a "Gestionar Niveles"
  2. Clic en "Nuevo Nivel"
  3. Completar:
     - Nombre (ej: Bronce, Plata, Oro)
     - Puntos mínimos requeridos
     - Puntos máximos del rango
     - Descripción
  4. Guardar
  
Postcondiciones:  Nivel creado
Ejemplo:          
  - Nivel: "Bronce" (0-100 pts)
  - Nivel: "Plata" (101-300 pts)
  - Nivel: "Oro" (301-500 pts)
```

---

### 4?? GESTIÓN DE MEDALLAS (Administrador)

#### CU-007: Crear Medalla
```
Actores:          Administrador
Precondiciones:   Administrador autenticado
Flujo Principal:
  1. Acceder a "Gestionar Medallas"
  2. Clic en "Nueva Medalla"
  3. Completar:
     - Nombre (ej: "Excelencia")
     - Descripción
     - Icono/Imagen
  4. Guardar
  
Postcondiciones:  Medalla disponible para docentes
```

---

### 5?? GESTIÓN DE INCENTIVOS (Administrador)

#### CU-008: Crear Incentivo
```
Actores:          Administrador
Precondiciones:   Administrador autenticado
Flujo Principal:
  1. Acceder a "Gestionar Incentivos"
  2. Clic en "Nuevo Incentivo"
  3. Completar:
     - Nombre (ej: "Bonus de Puntaje")
     - Descripción
     - Puntos requeridos para obtenerlo
     - Activo (Si/No)
  4. Guardar
  
Postcondiciones:  Incentivo se otorga automáticamente
Notas:            Se otorga automáticamente cuando estudiante
                  alcanza los puntos requeridos
```

---

### 6?? CREAR ACTIVIDAD (Docente)

#### CU-009: Crear Nueva Actividad ? (STRATEGY + DECORATOR)
```
Actores:          Docente
Precondiciones:   Docente autenticado, tiene cursos asignados
Flujo Principal:
  1. Acceder a "Panel Docente" ? "Crear Actividad"
  2. Completar formulario:
     - Título (obligatorio)
     - Descripción
     - Puntaje máximo (0-1000)
     - Curso (seleccionar de sus cursos)
     - Fecha límite (opcional)
     - Nivel de dificultad (normal/difícil/muy_difícil)
  3. Guardar actividad
  
Postcondiciones:  Actividad creada, asignada a estudiantes del curso
Patrones usados:  
  ? DECORATOR - NivelDificultad agregado al modelo
  ? Propiedades calculadas para PuntajeConModificadores

Notas:
  - Si NivelDificultad = "difícil" ? +20% puntaje
  - Si NivelDificultad = "muy_difícil" ? +35% puntaje
  - Si FechaLimite < 2 días ? EsUrgente = true ? +15% puntaje
```

---

### 7?? CALIFICAR ACTIVIDAD (Docente) ? (STRATEGY + FACTORY + OBSERVER)

#### CU-010: Calificar Actividad de Estudiante
```
Actores:          Docente
Precondiciones:   Actividad entregada por estudiante
Flujo Principal:
  1. Acceder a "Calificar Actividades"
  2. Ver lista de entregas sin calificar
  3. Seleccionar una entrega
  4. Clic en "Calificar"
  5. Ingresar:
     - Puntaje obtenido (0 - puntaje máximo)
     - Estrategia de calificación:
       ? Estándar (sin modificaciones)
       ? Bonificación (+10% si entregó a tiempo)
       ? Penalización (-20% si entregó tarde)
  6. Guardar calificación
  
Postcondiciones:  
  ? Calificación registrada
  ? Puntaje del estudiante actualizado
  ? Nivel del estudiante recalculado
  ? Incentivos otorgados automáticamente
  ? Log registrado

Patrones usados:
  ? STRATEGY - Selecciona algoritmo de cálculo
  ? FACTORY METHOD - Crea estrategia dinámicamente
  ? OBSERVER - LogCalificacionObserver notificado
  ? CONTROLLER (GRASP) - CalificacionBusinessController procesa
  ? HIGH COHESION - GamificacionService actualiza puntos/nivel

Flujo de Negocio:
  1. Factory crea estrategia elegida
  2. Strategy calcula puntaje según regla
  3. Observer registra en logs
  4. GamificacionService actualiza estudiante
  5. OtorgarIncentivosAutomaticos() verifica criterios
  
Ejemplo:
  - Puntaje asignado: 80
  - Estrategia: Bonificación
  - Entregó a tiempo: Sí
  - Resultado: 80 + (80 * 0.10) = 88 puntos
  - Log: "Actividad calificada - Estudiante: abc123, Puntaje: 88"
```

---

### 8?? OTORGAR MEDALLAS (Docente)

#### CU-011: Otorgar Medalla a Estudiante
```
Actores:          Docente
Precondiciones:   Estudiante tiene actividades entregadas
Flujo Principal:
  1. Acceder a "Otorgar Medallas"
  2. Seleccionar:
     - Estudiante
     - Medalla a otorgar
     - Motivo (opcional)
  3. Clic en "Otorgar Medalla"
  4. Sistema verifica:
     - Estudiante no tiene ya esa medalla
  
Postcondiciones:  Medalla registrada en historial
Excepciones:      Mostrar error si estudiante ya tiene medalla
```

#### CU-012: Editar Medalla Otorgada
```
Actores:          Docente (que la otorgó)
Precondiciones:   Medalla ya otorgada
Flujo Principal:
  1. Ver lista de "Medallas Otorgadas"
  2. Clic en "Editar"
  3. Cambiar medalla
  4. Guardar

Postcondiciones:  Medalla actualizada
Restricción:      Solo puede editar sus propias medallas
```

#### CU-013: Eliminar Medalla Otorgada
```
Actores:          Docente (que la otorgó)
Precondiciones:   Medalla otorgada existe
Flujo Principal:
  1. Ver "Medallas Otorgadas"
  2. Clic en "Eliminar"
  3. Confirmar acción

Postcondiciones:  Medalla eliminada del historial
```

---

### 9?? VER RANKING (Docente)

#### CU-014: Consultar Ranking de Desempeño ? (HIGH COHESION)
```
Actores:          Docente
Precondiciones:   Tiene estudiantes en sus cursos
Flujo Principal:
  1. Acceder a "Ver Ranking"
  2. Sistema muestra tabla con:
     - Posición (ranking)
     - Nombre del estudiante
     - Email
     - Puntaje total
     - Nivel actual
     - Cantidad de medallas
  3. Ordenado por puntaje (descendente)
  4. Limitar a top 100 estudiantes

Postcondiciones:  Ranking mostrado correctamente
Patrón usado:     HIGH COHESION - GamificacionService.ObtenerEstadisticas()
```

---

### ?? REALIZAR ACTIVIDAD (Estudiante)

#### CU-015: Entreegar Actividad
```
Actores:          Estudiante
Precondiciones:   Actividad asignada, no calificada aún
Flujo Principal:
  1. Acceder a "Mis Actividades"
  2. Ver actividades disponibles
  3. Seleccionar actividad
  4. Si ver detalles:
     - Título con decoradores (ej: "???? MUY DIFÍCIL - ? URGENTE")
     - Descripción
     - Puntaje normal: 100 pts
     - Puntaje con modificadores: 155 pts
     - Fecha límite
     - Archivo de actividad (si existe)
  5. Clic en "Realizar Actividad"
  6. Cargar archivo (documento, código, etc.)
  7. Confirmar entrega

Postcondiciones:  Actividad marcada como "Entregada"
Patrón usado:     DECORATOR - Muestra PuntajeConModificadores
Notas:            
  - Puede ver cálculo de puntaje antes de entregar
  - Sistema calcula bonificaciones de dificultad y urgencia
```

---

### 1??1?? VER PROGRESO (Estudiante)

#### CU-016: Consultar Progreso Académico ? (HIGH COHESION)
```
Actores:          Estudiante
Precondiciones:   Estudiante autenticado
Flujo Principal:
  1. Acceder a "Mi Perfil" o "Mis Estadísticas"
  2. Ver información:
     - Puntaje total acumulado
     - Nivel actual (ej: "Plata")
     - Progreso hacia siguiente nivel (barra)
     - Actividades completadas
     - Medallas obtenidas
     - Incentivos obtenidos
  3. Historial de actividades:
     - Nombre actividad
     - Puntaje obtenido
     - Fecha calificación
     - Estado (Pendiente/Calificada)

Postcondiciones:  Estadísticas mostradas
Patrón usado:     HIGH COHESION - GamificacionService.ObtenerEstadisticas()
```

#### CU-017: Ver Ranking General
```
Actores:          Estudiante
Precondiciones:   Estudiante autenticado
Flujo Principal:
  1. Acceder a "Ranking General"
  2. Ver ranking de estudiantes ordenado por puntaje
  3. Ver su posición en ranking
  4. Comparar con otros

Postcondiciones:  Ranking visualizado
```

---

## ?? FLUJOS SECUNDARIOS

### ?? Actualización Automática de Nivel

```
Trigger: Cuando estudiante recibe calificación
Evento:  CalificacionBusinessController.ProcesarCalificacion()
Flujo:
  1. GamificacionService.ActualizarPuntajeYNivel() es llamado
  2. Suma puntos a estudiante
  3. Busca nivel que corresponde a rango de puntos
  4. Si cambió nivel ? Mostrar notificación ??
  5. Retorna ActualizacionGamificacion con:
     - PuntosGanados
     - PuntajeTotalActual
     - NivelAnterior / NivelActual
     - CambioDeNivel (bool)

Patrón: HIGH COHESION (GRASP)
```

### ?? Otorgamiento Automático de Incentivos

```
Trigger: Después de actualizar puntaje
Evento:  GamificacionService.OtorgarIncentivosAutomaticos()
Flujo:
  1. Obtiene lista de incentivos activos
  2. Para cada incentivo:
     - Verifica si estudiante alcanzó puntos requeridos
     - Verifica si ya lo tiene
  3. Si aplica y no lo tiene:
     - Crea registro IncentivoEstudiante
     - Registra fecha y puntaje al obtenerlo
  4. Guarda cambios en BD

Patrón: HIGH COHESION (GRASP)
```

### ?? Registro Automático de Eventos (Observer)

```
Trigger: Cada calificación
Evento:  CalificacionNotifier.NotificarCalificacion()
Flujo:
  1. CalificacionNotifier ejecuta todos los observadores
  2. LogCalificacionObserver.OnActividadCalificada():
     - Registra en logs:
       "Actividad calificada - Estudiante: {id}, 
        Actividad: {id}, Puntaje: {pts}"

Patrón: OBSERVER (GoF)
```

---

## ?? MATRIZ DE PATRONES POR CASO DE USO

```
??????????????????????????????????????????????????????????????????
? CASO DE USO          ? PATRONES USADOS                         ?
??????????????????????????????????????????????????????????????????
? CU-009: Crear        ? DECORATOR (NivelDificultad)             ?
?         Actividad    ?                                          ?
??????????????????????????????????????????????????????????????????
? CU-010: Calificar    ? STRATEGY (3 algoritmos)                 ?
?         Actividad    ? FACTORY METHOD (crear estrategia)       ?
?                      ? OBSERVER (registrar evento)             ?
?                      ? CONTROLLER (GRASP - negocio separado)   ?
?                      ? HIGH COHESION (servicios especializados)?
??????????????????????????????????????????????????????????????????
? CU-014: Ver Ranking  ? HIGH COHESION (GamificacionService)     ?
??????????????????????????????????????????????????????????????????
? CU-015: Entregar     ? DECORATOR (visualizar modificadores)    ?
?         Actividad    ?                                          ?
??????????????????????????????????????????????????????????????????
? CU-016: Ver Progreso ? HIGH COHESION (GamificacionService)     ?
??????????????????????????????????????????????????????????????????
? (Automático)         ? OBSERVER (LogCalificacionObserver)      ?
? Otorgar Incentivos   ? HIGH COHESION (GamificacionService)     ?
??????????????????????????????????????????????????????????????????
```

---

## ?? MAPA DE NAVEGACIÓN

```
?? HOME (index)
?
?? ADMINISTRADOR
?  ?? Gestionar Usuarios
?  ?  ?? Crear Usuario
?  ?  ?? Editar Usuario
?  ?  ?? Activar/Desactivar
?  ?? Gestionar Cursos
?  ?  ?? Crear Curso
?  ?  ?? Asignar Docentes
?  ?? Gestionar Niveles
?  ?  ?? Crear/Editar Nivel
?  ?? Gestionar Medallas
?  ?  ?? Crear/Editar Medalla
?  ?? Gestionar Incentivos
?     ?? Crear/Editar Incentivo
?
?? DOCENTE
?  ?? Crear Actividad
?  ?? Calificar Actividades ? (con STRATEGY)
?  ?? Otorgar Medallas
?  ?  ?? Editar Medalla Otorgada
?  ?  ?? Eliminar Medalla Otorgada
?  ?? Ver Ranking
?
?? ESTUDIANTE
   ?? Mis Actividades
   ?  ?? Realizar/Entregar Actividad ? (con DECORATOR)
   ?? Mi Perfil
   ?  ?? Estadísticas ? (con HIGH COHESION)
   ?? Ranking General
```

---

## ??? MODELO DE DATOS SIMPLIFICADO

```
ApplicationUser
?? Id (PK)
?? Nombres
?? Apellidos
?? Email
?? PuntajeTotal
?? IdNivel (FK)
?? Estado

Nivel
?? IdNivel (PK)
?? Nombre
?? PuntajeMinimo
?? PuntajeMaximo
?? Descripcion

Curso
?? IdCurso (PK)
?? Nombre
?? Descripcion
?? Semestre

Actividad ? (CON DECORATOR)
?? IdActividad (PK)
?? Titulo
?? Descripcion
?? Puntaje
?? IdCurso (FK)
?? FechaCreacion
?? FechaLimite
?? NivelDificultad (DECORATOR)
?? Propiedades calculadas:
   ?? EsUrgente
   ?? PuntajeConModificadores
   ?? DescripcionConModificadores

ActividadEstudiante
?? IdActividadEstudiante (PK)
?? IdActividad (FK)
?? IdEstudiante (FK)
?? FechaEntrega
?? PuntajeObtenido

Medalla
?? IdMedalla (PK)
?? Nombre
?? Descripcion
?? Icono

MedallaEstudiante
?? IdMedallaEstudiante (PK)
?? IdMedalla (FK)
?? IdEstudiante (FK)
?? IdDocente (FK - quien la otorgó)
?? FechaOtorgada

Incentivo
?? IdIncentivo (PK)
?? Nombre
?? Descripcion
?? PuntosRequeridos
?? Activo

IncentivoEstudiante
?? IdIncentivo (FK)
?? IdEstudiante (FK)
?? FechaOtorgado
?? PuntajeAlObtener

CursoDocente
?? IdCurso (FK)
?? IdDocente (FK)
```

---

## ?? SEGURIDAD Y RESTRICCIONES

```
? Autenticación: ASP.NET Core Identity
? Autorización por roles: Administrador, Docente, Estudiante

RESTRICCIONES POR ROLE:

ADMINISTRADOR:
?? Acceso a toda la plataforma
?? Puede crear/editar usuarios
?? Puede gestionar cursos
?? Puede gestionar niveles, medallas, incentivos
?? NO puede calificar actividades

DOCENTE:
?? Acceso a sus cursos asignados
?? Puede ver solo estudiantes de sus cursos
?? Puede crear actividades en sus cursos
?? Puede calificar actividades de sus estudiantes
?? Puede otorgar medallas
?? Puede ver ranking de sus estudiantes
?? NO puede editar niveles/medallas/incentivos

ESTUDIANTE:
?? Acceso a sus cursos
?? Puede ver solo sus actividades
?? Puede entregar actividades
?? Puede ver su progreso
?? Puede ver ranking general
?? NO puede calificar ni otorgar medallas
```

---

## ? RESTRICCIONES TÉCNICAS

```
? Puntaje actividad: 0 - 1000
? PuntajeTotal estudiante: sin límite (acumulativo)
? Estrategias de calificación: máximo puntajeMaximo
? Cambio de nivel: automático al cumplir rango
? Medallas: una por estudiante (no duplicadas)
? Incentivos: se otorgan automáticamente
? Actividades: una vez calificada, no se puede modificar puntaje
? Fecha límite: opcional, pero afecta cálculo de urgencia
? NivelDificultad: normal/difícil/muy_difícil
```

---

## ?? CASOS DE ERROR

```
CU-010 CALIFICAR ACTIVIDAD (Excepciones):

? ERROR-001: Actividad no encontrada
   ? Mensaje: "Actividad no encontrada"
   ? Redirigir a lista de calificaciones

? ERROR-002: Puntaje fuera de rango
   ? Validación: 0 ? Puntaje ? PuntajeMaximo
   ? Mensaje: "El puntaje debe estar entre 0 y {max}"

? ERROR-003: Estudiante no existe
   ? Validación en BD
   ? Mensaje: "Estudiante no encontrado"

? ERROR-004: Estrategia inválida
   ? Valores válidos: estandar/bonificacion/penalizacion
   ? Default: estandar

? ERROR-005: Sin permisos
   ? Si docente intenta calificar actividad de otro docente
   ? Mensaje: "No tienes permisos para calificar esta actividad"
```

---

## ?? EJEMPLO COMPLETO: FLUJO DE CALIFICACIÓN

```
ESCENARIO: Docente califica actividad con Bonificación

PASO 1: Docente accede a "Calificar Actividades"
        ?? Ve lista de entregas sin calificar

PASO 2: Selecciona estudiante "Juan Pérez"
        ?? Actividad: "Proyecto Final" (100 pts)

PASO 3: Ingresa datos:
        ?? Puntaje: 80
        ?? Estrategia: Bonificación
        ?? Entregó a tiempo: Sí (FechaEntrega < FechaLimite)

PASO 4: Sistema procesa (CU-010):
        ?? Factory crea: CalificacionConBonificacionStrategy
        ?? Strategy calcula: 80 + (80 * 0.10) = 88 pts
        ?? Observer registra:
        ?  "Actividad calificada - Estudiante: juan_id, 
        ?   Actividad: 5, Puntaje: 88"
        ?? HIGH COHESION actualiza:
           ?? PuntajeTotal: 150 ? 238
           ?? Nivel: Bronce ? Plata (si 238 > 101)
           ?? Incentivos: verifica criterios

PASO 5: Respuesta al docente:
        "? Puntaje bonificado: 80 + 8 = 88 pts (Entrega puntual)
         ?? Juan subió de nivel: Bronce ? Plata
         ?? Incentivos obtenidos: Medalla de Oro"

PASO 6: Sistema actualiza:
        ?? ActividadEstudiante.PuntajeObtenido = 88
        ?? ApplicationUser.PuntajeTotal = 238
        ?? ApplicationUser.IdNivel = IdNivelPlata
        ?? IncentivoEstudiante registra nuevo incentivo

RESULTADO: ? Calificación registrada correctamente
```

---

## ?? ESPECIFICACIONES TÉCNICAS

### Patrón STRATEGY - Estrategias de Calificación

```
ICalificacionStrategy
?? CalcularPuntaje(puntajeMaximo, puntajeObtenido, entregadoATiempo)
?? NombreEstrategia

Implementaciones:
1. CalificacionEstandarStrategy
   ?? Retorna puntaje sin cambios

2. CalificacionConBonificacionStrategy
   ?? Si entregadoATiempo: puntaje += 10%
   ?? Máximo: puntajeMaximo

3. CalificacionConPenalizacionStrategy
   ?? Si NO entregadoATiempo: puntaje -= 20%
   ?? Mínimo: 0
```

### Patrón FACTORY METHOD - Creación Dinámmica

```
ICalificacionStrategyFactory
?? CrearEstrategia(string tipoEstrategia)

CalificacionStrategyFactory
?? switch(tipo.ToLower()):
   ?? "bonificacion" ? CalificacionConBonificacionStrategy()
   ?? "penalizacion" ? CalificacionConPenalizacionStrategy()
   ?? default       ? CalificacionEstandarStrategy()
```

### Patrón OBSERVER - Notificaciones

```
ICalificacionObserver
?? OnActividadCalificada(estudianteId, actividadId, puntaje)

Implementaciones:
1. LogCalificacionObserver
   ?? Registra en logs: 
      "Actividad calificada - Estudiante: {id}, 
       Actividad: {id}, Puntaje: {pts}"
```

### Patrón DECORATOR - Modificadores de Actividad

```
Actividad.NivelDificultad (en BD):
?? "normal"      ? +0%
?? "dificil"     ? +20%
?? "muy_dificil" ? +35%

Actividad.EsUrgente (calculado):
?? true si FechaLimite - Hoy < 2 días ? +15%

Actividad.PuntajeConModificadores (propiedad calculada):
?? Aplica modificadores acumulativamente

Actividad.DescripcionConModificadores (propiedad calculada):
?? Añade emojis: ?? DIFÍCIL, ? URGENTE
```

### Principio CONTROLLER (GRASP)

```
CalificacionBusinessController
?? ProcesarCalificacion():
?  ?? Valida datos
?  ?? Aplica estrategia
?  ?? Actualiza modelo
?  ?? Notifica observadores
?  ?? Retorna ResultadoCalificacion
?? GenerarMensajeResultado(): string
```

### Principio HIGH COHESION (GRASP)

```
GamificacionService
?? ActualizarPuntajeYNivel(estudianteId, puntos)
?  ?? Retorna ActualizacionGamificacion
?? OtorgarIncentivosAutomaticos(estudianteId)
?  ?? Retorna List<string> con nombres
?? ObtenerEstadisticas(estudianteId)
   ?? Retorna EstadisticasEstudiante
```

---

## ? CHECKLIST DE VALIDACIÓN

```
Requisitos Funcionales:
? Sistema permite crear actividades
? Sistema permite calificar con 3 estrategias diferentes
? Sistema otorga puntos automáticamente
? Sistema actualiza niveles automáticamente
? Sistema otorga incentivos automáticamente
? Sistema registra eventos en logs
? Sistema permite otorgar medallas

Requisitos No-Funcionales:
? Compilación sin errores
? 0 advertencias
? Patrón STRATEGY implementado
? Patrón FACTORY METHOD implementado
? Patrón OBSERVER implementado
? Patrón DECORATOR implementado
? Principio CONTROLLER implementado
? Principio HIGH COHESION implementado
? Código autodocumentado (Clean Code)
? Nombres descriptivos
```

---

## ?? DOCUMENTACIÓN RELACIONADA

- `PATRONES_IMPLEMENTADOS.md` - Detalles técnicos de cada patrón
- `GUIA_DE_USO.md` - Cómo usar cada patrón en la práctica
- `LIMPIEZA_COMENTARIOS.md` - Estándares de código aplicados
- `RESUMEN_REFACTORIZACION.md` - Mejoras de código realizadas

---

**Versión:** 1.0  
**Fecha:** Diciembre 2024  
**Proyecto:** RunaTalento - Plataforma de Gamificación Académica  
**Framework:** .NET 8.0 / ASP.NET Core MVC

---

**Estado:** ? **ESPECIFICACIÓN COMPLETA**
