# Instrucciones globales — ETC System

Reglas que aplican a TODOS los agentes del workspace.

## Clarificación de requisitos

Si el usuario pide algo ambiguo, incompleto, o con términos no definidos:
- Invoca a @el-de-las-gafas (dominio) o @el-investigador (web) para clarificar

## Agentes disponibles (14)

Usa exclusivamente a estos agentes. Solo usa @explore o @general si el usuario lo pide explícitamente.

### ETC — El Septeto Calavera (desarrollo)
- @el-maestro — TDD, features, tests
- @bug-doctor — Debugging, diagnóstico
- @el-de-las-gafas — Dominio, documentación, investigación web
- @las-manos — Infraestructura, CI/CD, instalación
- @el-pintor — Frontend, UI, animaciones
- @el-herrero — Backend, APIs, bases de datos
- @el-arbitro — Resolución de conflictos entre agentes

### System Agents (sistema)
- @el-explorador — Exploración de código, búsqueda, solo lectura
- @el-operador — Ejecución general, scripts, automatización
- @el-investigador — Web scraping, documentación, verificación
- @el-instalador — Paquetes, dependencias, tooling
- @el-configurador — Configuraciones, dotfiles, entorno
- @el-integrador — APIs, cuentas, servicios externos
- @el-supervisor — Resolución de conflictos, decisión de ruta

## Hooks de integración Superpowers

| # | Inicia | Gatillo | Invoca a | Resultado |
|---|---|---|---|---|
| **S-W1** | ⚖️ Supervisor | Design doc aprobado por el usuario | 🖐️ Las Manos | Worktree aislado creado y baseline de tests verificado |
| **C-P1** | ⚖️ Supervisor | Design doc firmado → listo para planificar | 🤓 El de las Gafas | Plan de implementación completo guardado en `docs/plans/` |
| **C-R1** | ⚖️ Supervisor | Subagente reporta DONE o DONE_WITH_CONCERNS | ⚖️ El Árbitro | Revisión 2 etapas: spec compliance → code quality |
| **S-W2** | ⚖️ Supervisor | Todas las tareas del plan completadas | 🖐️ Las Manos | Rama cerrada, worktree limpio, merge/PR ejecutado |

## Protocolo de status entre agentes

Al completar una tarea delegada, reportar SIEMPRE uno de estos estados:

  DONE               — tarea completada sin incidencias
  DONE_WITH_CONCERNS — completada, pero hay algo que el Supervisor debe revisar
  BLOCKED            — no puede avanzar, necesita intervención externa
  NEEDS_CONTEXT      — falta información específica para proceder

El Supervisor gestiona cada estado:
  DONE               → continuar con la siguiente tarea del plan
  DONE_WITH_CONCERNS → invocar Árbitro antes de continuar (hook C-R1)
  BLOCKED            → re-despachar con más contexto, partir la tarea, o escalar al usuario
  NEEDS_CONTEXT      → proveer el contexto exacto que falta y re-despachar

## Regla de delegación

Cuando delegues una tarea, eres responsable del resultado final.
Audita siempre lo que recibas del agente especializado antes de presentarlo.
