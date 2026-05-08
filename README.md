# 💀 ETC — El Trío Calavera

Configuración de agentes y skills para [OpenCode](https://opencode.ai), el entorno de codificación con IA. Este repo alberga a **ETC — El Trío Calavera**, tres agentes especializados que forman un equipo de desarrollo completo, más 17 skills complementarias.

> _«Uno escribe el código, otro lo cura, el tercero lo cuestiona. Juntos: ETC — El Trío Calavera.»_

## 💀 ETC — Las 3 Skills/Agents Principales

| ETC | Personaje | Rol | Frase |
|-----|-----------|-----|-------|
| 🧪 | **El Maestro** | TDD Orchestrator | _"Sin tests no hay commit."_ |
| 🩺 | **Bug Doctor** | Diagnóstico Forense | _"Sin repro, no toco el código."_ |
| 🤓 | **El de las Gafas** | Domain Moderator | _"Una palabra ambigua hoy es un bug mañana."_ |

---

### 🧪 El Maestro — TDD Orchestrator

Orquesta el ciclo completo de desarrollo guiado por pruebas: **INIT → PLAN → RED → GREEN → REFACTOR → REVIEW → COMMIT**. No escribe código directamente — guía el proceso con disciplina, exigiendo 90%+ de cobertura y 0 errores de análisis estático.

**Origen**: [morodomi/tdd-skills](https://github.com/morodomi/tdd-skills)

### 🩺 Bug Doctor — Diagnóstico Disciplinado de Bugs

Diagnostica bugs complejos con un método forense de 6 fases. Su principio fundamental: sin un loop de feedback determinista, mirar código es perder el tiempo. Reproduce, minimiza, formula hipótesis falsificables, instrumenta, corrige y blinda con tests de regresión.

**Origen**: [morodomi/tdd-skills](https://github.com/morodomi/tdd-skills)

### 🤓 El de las Gafas — Domain Moderator

Moderador de dominio que ve lo que otros pasan por alto: términos ambiguos, contradicciones entre código y discurso, decisiones no documentadas. Actualiza `CONTEXT.md` y crea ADRs en vivo mientras las decisiones cristalizan. Aplica principios de Domain-Driven Design.

**Origen**: [mattpocock/skills](https://github.com/mattpocock/skills)

---

## Estructura de Archivos

Para implementar estas skills en tu proyecto, necesitas esta estructura:

```
tu-proyecto/
├── .opencode/
│   ├── .gitignore           # node_modules, package.json, etc.
│   ├── agents/              # Agentes (subagentes autónomos)
│   │   ├── el-maestro.md
│   │   ├── bug-doctor.md
│   │   └── el-de-las-gafas.md
│   └── skills/              # Skills (instrucciones especializadas)
│       ├── el-maestro/
│       │   └── SKILL.md
│       ├── bug-doctor/
│       │   └── SKILL.md
│       ├── el-de-las-gafas/
│       │   ├── SKILL.md
│       │   ├── ADR-FORMAT.md
│       │   └── CONTEXT-FORMAT.md
│       └── ... (17 skills adicionales)
├── opencode.json            # Configuración de permisos
└── README.md
```

### Disponibilidad Global

Para que las skills y agentes estén disponibles en **todos** tus proyectos, copia el contenido de `.opencode/` a `~/.config/opencode/`:

```bash
cp -r .opencode/skills/* ~/.config/opencode/skills/
cp -r .opencode/agents/* ~/.config/opencode/agents/
```

OpenCode carga skills y agentes desde:
1. **`.opencode/` del proyecto** (específico del proyecto, tiene prioridad)
2. **`~/.config/opencode/`** (global, disponible en todos los proyectos)

---

## Formato de los Archivos

### Skill: `SKILL.md`

Cada skill vive en su propio directorio bajo `.opencode/skills/<nombre>/` con un archivo `SKILL.md`. El formato incluye frontmatter YAML:

```yaml
---
name: nombre-de-la-skill
description: Qué hace y cuándo usarla
license: MIT
compatibility: opencode
---

# Título de la Skill

Instrucciones completas para el modelo...
```

**Reglas**:
- El directorio se nombra igual que la skill
- El archivo debe llamarse exactamente `SKILL.md`
- El frontmatter es obligatorio: `name`, `description`, `license`, `compatibility`
- Las skills se cargan al inicio de la conversación mediante la herramienta `skill`

### Agent: `.md` con frontmatter

Cada agente vive en `.opencode/agents/<nombre>.md`. El formato incluye frontmatter YAML con `mode: subagent`:

```yaml
---
description: Descripción de cuándo usar este agente
mode: subagent
---

# Nombre del Agente

Instrucciones completas de personalidad, misión, reglas y flujo de trabajo...
```

**Reglas**:
- El archivo se nombra igual que el agente: `el-maestro.md`
- `mode: subagent` es obligatorio para que OpenCode lo reconozca como agente autónomo
- Los agentes se invocan con `@nombre-del-agente` en el chat

### Configuración: `opencode.json`

Controla los permisos de las skills:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "permission": {
    "skill": {
      "*": "allow"
    }
  }
}
```

---

## Cómo se Usan

Hay tres formas de invocar skills y agentes en OpenCode:

| Método | Sintaxis | Aplica a | Ejemplo |
|--------|----------|----------|---------|
| **@mención** | `@el-maestro` | Agents | `@el-maestro implementa login con JWT` |
| **/comando** | `/el-maestro` | Skills y Agents | `/bug-doctor` |
| **Lenguaje natural** | Describir la tarea | Skills | "Necesito diagnosticar un bug intermitente" |

### Diferencia clave: Skill vs Agent

| | **Skill** | **Agent** |
|---|---|---|
| **Propósito** | Instrucciones para Plan/Build | Subagente autónomo con personalidad |
| **Invocación** | `/skill` o lenguaje natural | `@agente` |
| **Contexto** | Se inyecta en la conversación actual | Ejecuta en un contexto aislado |
| **Archivo** | `.opencode/skills/<nombre>/SKILL.md` | `.opencode/agents/<nombre>.md` |

Las 3 skills principales existen en **ambos formatos** — como skill (para usar con `/el-maestro` o lenguaje natural) y como agent (para usar con `@el-maestro`). Esto permite máxima flexibilidad.

---

## 🤝 Colaboración entre Agentes

Los 3 agentes de ETC no trabajan en aislamiento — se invocan entre sí automáticamente según el contexto. Hay **14 hooks de colaboración** documentados en sus instrucciones, formando un sistema vivo donde el conocimiento fluye entre diagnóstico, implementación y clarificación.

> _«El Maestro implementa, Bug Doctor diagnostica, El de las Gafas clarifica. El que calla una duda al compañero, la paga con un bug.»_

### El patrón: Implementar → Diagnosticar → Clarificar

Cada agente tiene un rol primario claro, y cuando detecta que está fuera de su especialidad, deriva al colega adecuado:

| Agente | Rol primario | Deriva a... |
|--------|-------------|-------------|
| 🧪 **El Maestro** | Implementar features y fixes con TDD | 🤓 Gafas (cuando el dominio es ambiguo) y 🩺 Bug Doctor (cuando hay bugs complejos) |
| 🩺 **Bug Doctor** | Diagnosticar causa raíz de bugs | 🧪 Maestro (para implementar el fix con TDD) y 🤓 Gafas (cuando el bug es síntoma de deuda de dominio) |
| 🤓 **El de las Gafas** | Clarificar el ubiquitous language y mantener documentación viva | 🧪 Maestro (para blindar reglas de dominio con tests) y 🩺 Bug Doctor (cuando la ambigüedad ya causó bugs) |

### Las 14 colaboraciones

Cada hook está numerado (C1–C14) y documentado en el archivo del agente que **inicia** la colaboración:

| # | Inicia | Gatillo | Invoca a | Resultado |
|---|--------|---------|----------|-----------|
| C1 | 🧪 Maestro | Modo Diagnóstico: bug complejo reportado | 🩺 Bug Doctor | Diagnóstico forense con causa raíz |
| C2 | 🧪 Maestro | INIT/PLAN: feature toca términos no documentados | 🤓 Gafas | Términos clarificados antes de diseñar |
| C3 | 🧪 Maestro | PLAN: se crean o modifican entidades de dominio | 🤓 Gafas | Diseño validado contra el glosario |
| C4 | 🧪 Maestro | PLAN con score BLOCK (60+) y riesgo de dominio | 🤓 Gafas | Segunda mirada en decisiones de alto impacto |
| C5 | 🧪 Maestro | REVIEW: naming inconsistente con CONTEXT.md | 🤓 Gafas | Código alineado con ubiquitous language |
| C6 | 🧪 Maestro | REVIEW: bugs descubiertos en código existente | 🩺 Bug Doctor | Bugs huérfanos diagnosticados |
| C7 | 🩺 Bug Doctor | Hipótesis involucra reglas de negocio | 🤓 Gafas | Verificación contra modelo de dominio |
| C8 | 🩺 Bug Doctor | Falta infraestructura de testing | 🧪 Maestro | Mini-ciclo TDD para test de repro |
| C9 | 🩺 Bug Doctor | Causa raíz confirmada, fix listo | 🧪 Maestro | Fix implementado con disciplina TDD |
| C10 | 🩺 Bug Doctor | Autopsia revela deuda de documentación | 🤓 Gafas | CONTEXT.md actualizado, ADR si procede |
| C11 | 🤓 Gafas | Contradicción grave código ↔ discurso | 🩺 Bug Doctor | Bug de lógica de negocio diagnosticado |
| C12 | 🤓 Gafas | Regla de dominio documentada sin tests | 🧪 Maestro | Ciclo TDD para blindar la regla |
| C13 | 🤓 Gafas | ADR que impacta arquitectura | 🧪 Maestro | Maestro notificado para futuras features |
| C14 | 🤓 Gafas | Patrón de ambigüedad recurrente (múltiples módulos) | 🩺 Bug Doctor | Diagnóstico preventivo de bugs latentes |

### Ciclos compuestos — cuando las 14 colaboraciones se encadenan

Los hooks no son eventos aislados: se encadenan formando ciclos compuestos que cubren escenarios completos de desarrollo:

#### 🐛🔍 "Bug revela deuda de dominio"

El ciclo más virtuoso: un bug expone que el lenguaje del dominio está corrupto, y los 3 agentes colaboran para curarlo de raíz.

```
C7: Bug Doctor → Gafas ("¿este bug es malentendido del dominio?")
 ↓
C11: Gafas → Bug Doctor ("sí, el código contradice el glosario. Diagnostica el impacto")
 ↓
C10: Bug Doctor → Gafas ("autopsia: documenta esto en CONTEXT.md para que no se repita")
 ↓
C14: Gafas → Bug Doctor ("hay un patrón de ambigüedad en 3 módulos. Diagnostica preventivamente")
```

**Resultado**: no solo se arregla el bug — se cura el lenguaje que lo causó y se previenen bugs futuros.

#### 🧪🤓 "Feature con validación de dominio"

Cuando El Maestro va a implementar una feature que toca reglas de negocio, El de las Gafas lo acompaña de principio a fin:

```
C2/C3/C4: Maestro → Gafas ("clarifica términos / revisa diseño / valida alto riesgo")
 ↓
C12: Gafas → Maestro ("esa regla de dominio no tiene tests. Abre un ciclo TDD para blindarla")
 ↓
C5: Maestro → Gafas ("código listo, ¿el naming respeta el glosario?")
 ↓
C13: Gafas → Maestro ("creé ADR-000X. Consúltalo en futuras features que toquen esto")
```

**Resultado**: la feature sale con ubiquitous language consistente, tests que blindan las reglas de dominio, y un ADR que guiará a quien toque ese código después.

#### 🩺🧪 "Fix con garantías TDD"

Bug Doctor encuentra la causa raíz, pero no implementa el fix a lo loco — se lo entrega al Maestro con todas las garantías:

```
C9: Bug Doctor → Maestro ("causa raíz confirmada. Toma el fix y mi test de regresión")
 ↓
Maestro ejecuta RED → GREEN → REFACTOR → REVIEW
 ↓
C6: Maestro → Bug Doctor ("encontré más bugs durante el quality-gate")
 ↓
C8: Bug Doctor → Maestro ("necesito tests de repro para estas hipótesis")
```

**Resultado**: el fix no es un parche — es un ciclo TDD completo con test de regresión, quality-gate, y bugs secundarios derivados.

#### 🤓🔍 "De la ambigüedad al blindaje"

Una sesión de clarificación de dominio dispara una cascada de acciones concretas:

```
C14: Gafas → Bug Doctor ("término X usado inconsistentemente. Diagnostica bugs latentes")
 ↓
C7: Bug Doctor → Gafas ("confirmado: la ambigüedad ya causó un bug sutil. ¿Está esto documentado?")
 ↓
C8: Bug Doctor → Maestro ("necesito tests de repro para blindar este edge case")
 ↓
C12: Gafas → Maestro ("regla documentada. Ahora blíndala con tests")
```

**Resultado**: lo que empezó como "este término es ambiguo" termina con documentación actualizada, bugs latentes diagnosticados, y tests que blindan el comportamiento correcto.

---

## Skills Complementarias

Además de las 3 principales, este repo incluye 17 skills adicionales para diferentes especialidades:

| Skill | Especialidad |
|-------|-------------|
| `accessibility-auditor` | Auditoría de accesibilidad WCAG |
| `api-tester` | Testing y validación de APIs |
| `backend-architect` | Diseño de sistemas escalables |
| `code-reviewer` | Revisión de código constructiva |
| `codebase-onboarding-engineer` | Onboarding a codebases desconocidos |
| `database-optimizer` | Optimización de esquemas y queries |
| `devops-automator` | CI/CD e infraestructura como código |
| `frontend-developer` | Desarrollo web moderno (React/Vue/Angular) |
| `git-workflow-master` | Estrategias de branching y conventional commits |
| `language-translator` | Traducción español ↔ inglés en tiempo real |
| `performance-benchmarker` | Medición y optimización de rendimiento |
| `product-manager` | Ciclo completo de producto (descubrimiento a GTM) |
| `rapid-prototyper` | Prototipado rápido y MVPs |
| `security-engineer` | Modelado de amenazas y código seguro |
| `software-architect` | Diseño de sistemas y DDD |
| `sre` | SLOs, error budgets, observabilidad |
| `technical-writer` | Documentación para desarrolladores |

Cada una sigue el mismo formato `SKILL.md` y puede copiarse a `~/.config/opencode/skills/` para disponibilidad global.

---

## Cómo Replicar Esto en Tu Proyecto

### Paso 1: Crear la estructura

```bash
mkdir -p .opencode/skills .opencode/agents
```

### Paso 2: Copiar las skills deseadas

```bash
# Desde este repo
cp -r .opencode/skills/el-maestro tu-proyecto/.opencode/skills/
cp -r .opencode/skills/bug-doctor tu-proyecto/.opencode/skills/
cp -r .opencode/skills/el-de-las-gafas tu-proyecto/.opencode/skills/

# Copiar los agents
cp .opencode/agents/el-maestro.md tu-proyecto/.opencode/agents/
cp .opencode/agents/bug-doctor.md tu-proyecto/.opencode/agents/
cp .opencode/agents/el-de-las-gafas.md tu-proyecto/.opencode/agents/
```

### Paso 3: Configurar opencode.json

```json
{
  "$schema": "https://opencode.ai/config.json",
  "permission": {
    "skill": {
      "*": "allow"
    }
  }
}
```

### Paso 4: (Opcional) Disponibilidad global

```bash
cp -r .opencode/skills/* ~/.config/opencode/skills/
cp -r .opencode/agents/* ~/.config/opencode/agents/
```

### Paso 5: Usar en OpenCode

Abre OpenCode en tu proyecto y escribe `@el-maestro` para iniciar un ciclo TDD, `@bug-doctor` para diagnosticar un bug, o `@el-de-las-gafas` para estresar tu modelo de dominio.

---

## Licencia

MIT — heredada de [morodomi/tdd-skills](https://github.com/morodomi/tdd-skills) y [mattpocock/skills](https://github.com/mattpocock/skills).
