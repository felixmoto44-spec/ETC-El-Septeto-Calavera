---
name: subagent-driven-development
description: Usar cuando haya un plan de implementación aprobado y se quiera ejecutarlo despachando subagentes frescos por tarea con revisión entre cada una.
license: MIT
compatibility: opencode
---

# subagent-driven-development

Usar cuando haya un plan de implementación aprobado y se quiera ejecutarlo
despachando subagentes frescos por tarea con revisión entre cada una.

## Anuncio obligatorio

Al activar esta skill decir:
"Estoy usando la skill subagent-driven-development para ejecutar el plan."

## Principio central

Subagente fresco por tarea + revisión en dos etapas = alta calidad, iteración rápida.

Por qué subagentes frescos:
- Cada subagente recibe exactamente el contexto que necesita para SU tarea.
- Nunca hereda el historial de la sesión del Supervisor.
- El Supervisor mantiene su contexto limpio: lista de tareas + resúmenes.
- Costo de tokens: ~15k (leer el plan una vez) + ~2k por tarea despachada.

## Paso 1 — Preparar la lista de tareas

Leer el plan completo una vez.
Crear una lista de tareas con: número, título, descripción breve (1 línea).
Registrar en TodoWrite para seguimiento persistente.

## Paso 2 — Despachar subagente por tarea

Para cada tarea del plan:

**a) Extraer el contexto exacto de esa tarea** (~3-5k chars):
- Descripción completa de la tarea.
- Archivos a crear o modificar (rutas exactas).
- Código a escribir.
- Comando de verificación.
- Skill a usar: test-driven-development.

**b) Seleccionar el agente correcto:**

| Tipo de tarea | Subagente |
|---|---|
| Implementar feature con tests | @el-maestro |
| Backend, APIs, base de datos | @el-herrero |
| Frontend, UI, componentes | @el-pintor |
| Infraestructura, deploy, scripts | @las-manos |
| Debugging de un fallo | @bug-doctor |

**c) Despachar con instrucciones precisas:**
```
Tarea: [título]
Archivos: [rutas exactas]
Qué hacer: [descripción completa de la tarea]
Verificación: [comando exacto para confirmar que funciona]
Skill requerida: test-driven-development
Estado al terminar: reportar DONE / DONE_WITH_CONCERNS / BLOCKED / NEEDS_CONTEXT
```

**d) El subagente NUNCA debe:**
- Modificar archivos fuera de los especificados en su tarea.
- Hacer suposiciones sobre el diseño — si hay ambigüedad, reportar NEEDS_CONTEXT.
- Escribir código antes de escribir el test.

## Paso 3 — Gestionar el status del subagente

| Estado reportado | Acción del Supervisor |
|---|---|
| `DONE` | Marcar tarea como completada en TodoWrite. Continuar con la siguiente. |
| `DONE_WITH_CONCERNS` | Invocar @el-arbitro para revisión (hook C-R1) antes de continuar. |
| `BLOCKED` | Re-despachar con más contexto. Si persiste, partir la tarea. Si sigue bloqueado, escalar al usuario. |
| `NEEDS_CONTEXT` | El subagente especificará qué falta. Proveer exactamente ese contexto y re-despachar. |

## Paso 4 — Revisión entre tareas (hook C-R1)

Después de cada DONE o DONE_WITH_CONCERNS, invocar @el-arbitro con:
- Descripción de lo implementado.
- Referencia al plan (ruta del archivo).
- SHA del commit base y SHA del commit actual.

El Árbitro devuelve: fortalezas, issues críticos, issues importantes, issues menores.

## Paso 5 — Revisión final

Al completar todas las tareas:
- Despachar @el-arbitro para revisión final de toda la implementación.
- Si pasa: activar hook S-W2 → invocar @las-manos para finishing-a-development-branch.
- Si hay issues críticos: resolverlos antes de cerrar la rama.

## Ejecución continua

NO pausar entre tareas para consultar al usuario salvo:
- Estado BLOCKED irresolvible.
- Ambigüedad que impide genuinamente avanzar.
- Todas las tareas completadas.

Las instrucciones explícitas del usuario siempre tienen prioridad sobre esta skill.
