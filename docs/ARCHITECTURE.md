# ETC Architecture — El Septeto Calavera + System Agents

## Visión General

ETC es un ecosistema de **14 agentes** organizados en dos capas complementarias:

```
┌─────────────────────────────────────────────────────────┐
│                    USUARIO                               │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│           BUILD / PLAN (Orquestadores)                   │
│           Solo delegan, no ejecutan                      │
└────┬──────────────────────────────────────┬─────────────┘
     │                                      │
┌────▼──────────────┐          ┌────────────▼─────────────┐
│ SYSTEM AGENTS (7) │          │  ETC SEPTETO (7)         │
│ Capa de sistema   │    ──►   │  Capa de desarrollo      │
└───────────────────┘          └──────────────────────────┘
```

## Los 14 Agentes

### System Agents — Capa de Sistema
| Agente | Rol | Responsabilidad |
|--------|-----|----------------|
| 🧭 Explorador | Codebase Explorer | Búsqueda y exploración read-only |
| 🛠️ Operador | General Executor | Scripts, automatización, tareas generales |
| 🔍 Investigador | Web Researcher | Búsqueda web, scraping, verificación |
| 📦 Instalador | Package Installer | Paquetes, dependencias, tooling |
| 🎛️ Configurador | System Configurator | Configs, dotfiles, variables de entorno |
| 🔗 Integrador | API Integrator | APIs externas, OAuth, cuentas |
| ⚖️ Supervisor | Agent Router | Router de tareas, resolución de conflictos |

### ETC Septeto — Capa de Desarrollo
| Agente | Rol | Responsabilidad |
|--------|-----|----------------|
| 🧪 El Maestro | TDD Orchestrator | Ciclo TDD, features, tests |
| 🩺 Bug Doctor | Diagnóstico Forense | Debugging, causa raíz, regresión |
| 🤓 El de las Gafas | Domain Moderator | DDD, ADRs, ubiquitous language |
| 🖐️ Las Manos | Infrastructure & Ops | CI/CD, Docker, secretos, APIs |
| 🎨 El Pintor | Frontend Expert | UI, animaciones, accesibilidad |
| ⚒️ El Herrero | Backend Expert | APIs, DBs, auth, arquitectura |
| ⚖️ El Árbitro | Conflict Resolution | Resuelve disputas entre agentes |

## Flujo de Trabajo
Ver `docs/plans/` para design docs y `CONTRIBUTING.md` para cómo añadir agentes/skills.
