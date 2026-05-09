---
name: requesting-code-review
description: Usar entre tareas para revisar el trabajo de un subagente antes de continuar con la siguiente tarea del plan.
license: MIT
compatibility: opencode
---

# requesting-code-review

Usar entre tareas para revisar el trabajo de un subagente antes de continuar
con la siguiente tarea del plan.

## Anuncio obligatorio

Al activar esta skill decir:
"Estoy usando la skill requesting-code-review para revisar la implementación."

## Información requerida para la revisión

El Supervisor debe proveer:
- **Descripción:** qué se implementó en esta tarea.
- **Plan de referencia:** ruta al archivo del plan en docs/plans/.
- **BASE_SHA:** SHA del commit anterior a esta tarea.
- **HEAD_SHA:** SHA del commit actual.

```bash
BASE_SHA=$(git log --oneline | grep "tarea anterior" | head -1 | awk '{print $1}')
HEAD_SHA=$(git rev-parse HEAD)
```

## Etapa 1 — Revisión de cumplimiento de spec

Comparar el diff (BASE_SHA..HEAD_SHA) contra los requisitos de la tarea en el plan:

- ¿Se implementó todo lo que la tarea pedía?
- ¿Se modificaron solo los archivos especificados?
- ¿Los tests cubren los casos descritos en el plan?
- ¿El comportamiento observable es el descrito en el diseño?

## Etapa 2 — Revisión de calidad de código

Independientemente del spec, revisar:

- ¿Hay duplicación evitable?
- ¿Las funciones tienen una sola responsabilidad?
- ¿Los nombres son claros y descriptivos?
- ¿El código nuevo sigue las convenciones del proyecto existente?
- ¿Hay magic numbers, strings hardcodeados o TODOs sin resolver?
- ¿Los tests son reales (verifican comportamiento) o triviales (solo ejecutan código)?

## Formato del reporte

```
## Revisión: Tarea N — [Título]

**Fortalezas:**
- [Lo que está bien hecho]

**Issues críticos** (bloquean avance):
- [Issue] → [Qué hay que corregir exactamente]

**Issues importantes** (resolver antes de tareas relacionadas):
- [Issue] → [Sugerencia]

**Issues menores** (puede continuar):
- [Issue] → [Nota]

**Evaluación:** ✅ Listo para continuar / ⚠️ Resolver críticos antes de continuar
```

## Severidad de issues

| Severidad | Definición | Acción |
|---|---|---|
| **Crítico** | Rompe funcionalidad, introduce bug, viola el spec | Bloquear avance. Corregir antes de la siguiente tarea. |
| **Importante** | Deuda técnica significativa, test inadecuado | Resolver antes de tareas relacionadas. |
| **Menor** | Style, naming, pequeñas mejoras | Puede continuar. Resolver en refactor final. |

## Issues críticos — el Árbitro bloquea

Si hay issues críticos:
1. Reportarlos claramente al Supervisor con instrucciones exactas de corrección.
2. El Supervisor re-despacha al subagente original con las correcciones requeridas.
3. No continuar con la siguiente tarea hasta que los críticos estén resueltos.
4. Re-revisar tras las correcciones.
