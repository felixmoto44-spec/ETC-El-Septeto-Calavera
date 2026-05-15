---
name: el-nexo
description: El Nexo — agente unificado de ETC. Punto de confluencia de 16 especialidades. Bug Doctor como safety net cuando falla el enfoque tradicional.
license: MIT
compatibility: opencode
---

# 🎯 Skill: El Nexo

Esta skill activa el agente unificado **et-calavera.md** que contiene los 16 dominios de ETC en un solo agente.

## Cuándo usar esta skill

- Cuando necesites un agente que cubra **todos los dominios** de desarrollo y sistema
- Cuando quieras el safety net de **Bug Doctor** ante fallos recurrentes
- Cuando no estés seguro de qué agente específico invocar
- Cuando quieras un **punto único de entrada** para el ecosistema ETC

## Qué contiene

| # | Dominio | Rol |
|---|---------|-----|
| 1 | 🎼 Maestro | TDD Orchestrator |
| 2 | ⚒️ Herrero | Backend Expert |
| 3 | 🎨 Pintor | Frontend Expert |
| 4 | 🖐️ Manos | Infrastructure & Operations |
| 5 | 🤓 Gafas | Domain Moderator |
| 6 | 🧭 Explorador | Codebase Explorer |
| 7 | 🛠️ Operador | General Executor |
| 8 | 🔍 Investigador | Web Researcher |
| 9 | 📦 Instalador | Package Installer |
| 10 | 🎛️ Configurador | System Configurator |
| 11 | 🔗 Integrador | API Integrator |
| 12 | ⚖️ Árbitro | Conflict Resolution |
| 13 | ⚖️ Supervisor | Agent Router |
| 14 | 📝 Secretario | User Profile & Communication |
| 15 | 🔬 Bug Doctor | Safety Net & Debugging |

## Innovación clave

**Bug Doctor como safety net**: Cada dominio opera con su enfoque tradicional, pero si falla 2 veces consecutivas en la misma tarea, Bug Doctor se activa automáticamente para diagnosticar la causa raíz.

## Cómo activarlo

El agente `et-calavera.md` debe estar registrado en `.opencode/agents/` y referenciado en `opencode.json`.

Una vez activo:
1. El agente identifica el dominio de la tarea
2. Activa el enfoque de ese dominio
3. Ejecuta según ese enfoque
4. Si falla 2 veces → activa Bug Doctor

## Relación con agentes existentes

Los agentes originales (el-maestro.md, bug-doctor.md, el-herrero.md, etc.) **no se eliminan ni modifican**. Este agente unificado es un complemento que ofrece una interfaz única para todo el ecosistema ETC.

## Archivos

- Agente: `.opencode/agents/et-calavera.md`
- Skill: `.opencode/skills/et-calavera/SKILL.md`
