# 💀 ETC — El Cuarteto Calavera

Configuración de agentes y skills para [OpenCode](https://opencode.ai), el entorno de codificación con IA. Este repo alberga a **ETC — El Cuarteto Calavera**, cuatro agentes especializados que forman un equipo de desarrollo completo, más 32 skills (4 de agentes + 28 complementarias).

> _«Uno escribe el código, otro lo cura, el tercero lo cuestiona, el cuarto lo despliega. Juntos: ETC — El Cuarteto Calavera.»_

## 💀 ETC — Las 4 Skills/Agents Principales

| ETC | Personaje | Rol | Frase |
|-----|-----------|-----|-------|
| 🧪 | **El Maestro** | TDD Orchestrator | _"Sin tests no hay commit."_ |
| 🩺 | **Bug Doctor** | Diagnóstico Forense | _"Sin repro, no toco el código."_ |
| 🤓 | **El de las Gafas** | Domain Moderator | _"Una palabra ambigua hoy es un bug mañana."_ |
| 🖐️ | **Las Manos** | Infrastructure & Ops | _"Si no está en código, no existe. Si no está automatizado, no escala."_ |

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

### 🖐️ Las Manos — Infrastructure & Operations Specialist

El cuarto calavera, especialista en todo lo operacional: pipelines de CI/CD, contenedores Docker, Infraestructura como Código, gestión de secretos, auditoría de dependencias, respuesta a incidentes, worktrees de git y seguridad operacional. Sin él, el código no llega a producción.

Incluye un **Modo Integración de APIs** para configurar servicios externos (Supabase, Stripe, Google OAuth, GitHub OAuth, AWS) con un flujo de 6 fases: diagnóstico, investigar, planear, ejecutar, verificar, y notificar al Maestro.

**Origen**: Diseñado desde cero para ETC, inspirado en [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) y [mattpocock/skills](https://github.com/mattpocock/skills).

---

## 🤝 Colaboración entre Agentes

Los 4 agentes de ETC no trabajan en aislamiento — se invocan entre sí automáticamente según el contexto. Hay **20 hooks de colaboración** (C1–C20) documentados en sus instrucciones, y cada agente integra internamente la lógica de sus especialidades.

> _«El Maestro implementa, Bug Doctor diagnostica, El de las Gafas clarifica, Las Manos despliega. El que calla una duda al compañero, la paga con un bug.»_

### El patrón: Implementar → Diagnosticar → Clarificar → Desplegar

Cada agente tiene un rol primario claro, y cuando detecta que está fuera de su especialidad, deriva al colega adecuado:

| Agente | Rol primario | Deriva a... |
|--------|-------------|-------------|
| 🧪 **El Maestro** | Implementar features y fixes con TDD | 🤓 Gafas (dominio), 🩺 Bug Doctor (bugs), 🖐️ Manos (deploy/env) |
| 🩺 **Bug Doctor** | Diagnosticar causa raíz de bugs | 🧪 Maestro (implementar fix), 🤓 Gafas (deuda de dominio), 🖐️ Manos (entorno/seguridad) |
| 🤓 **El de las Gafas** | Clarificar ubiquitous language y documentación | 🧪 Maestro (blindar con tests), 🩺 Bug Doctor (bugs por ambigüedad), 🖐️ Manos (infra/secretos) |
| 🖐️ **Las Manos** | Infraestructura, CI/CD, secretos, dependencias, incidentes, worktrees, auditoría de skills | 🧪 Maestro (deploy feature), 🩺 Bug Doctor (incidentes), 🤓 Gafas (ADR operacionales) |

### Los 20 hooks de colaboración (C1–C20)

#### Hooks C1–C14: El Trío Original (Maestro ↔ Bug Doctor ↔ Gafas)

| # | Inicia | Gatillo | Invoca a | Resultado |
|---|--------|---------|----------|-----------|
| C1 | 🧪 Maestro | Bug complejo reportado | 🩺 Bug Doctor | Diagnóstico forense |
| C2 | 🧪 Maestro | Feature toca términos no documentados | 🤓 Gafas | Términos clarificados |
| C3 | 🧪 Maestro | Se crean/modifican entidades de dominio | 🤓 Gafas | Diseño validado contra glosario |
| C4 | 🧪 Maestro | PLAN con score BLOCK (60+) | 🤓 Gafas | Segunda mirada en alto riesgo |
| C5 | 🧪 Maestro | Naming inconsistente con CONTEXT.md | 🤓 Gafas | Código alineado con ubiquitous language |
| C6 | 🧪 Maestro | Bugs descubiertos en código existente | 🩺 Bug Doctor | Bugs huérfanos diagnosticados |
| C7 | 🩺 Bug Doctor | Hipótesis involucra reglas de negocio | 🤓 Gafas | Verificación contra modelo de dominio |
| C8 | 🩺 Bug Doctor | Falta infraestructura de testing | 🧪 Maestro | Mini-ciclo TDD para test de repro |
| C9 | 🩺 Bug Doctor | Causa raíz confirmada, fix listo | 🧪 Maestro | Fix con disciplina TDD |
| C10 | 🩺 Bug Doctor | Autopsia revela deuda de documentación | 🤓 Gafas | CONTEXT.md actualizado |
| C11 | 🤓 Gafas | Contradicción grave código ↔ discurso | 🩺 Bug Doctor | Bug de lógica de negocio diagnosticado |
| C12 | 🤓 Gafas | Regla de dominio sin tests | 🧪 Maestro | Ciclo TDD para blindar |
| C13 | 🤓 Gafas | ADR que impacta arquitectura | 🧪 Maestro | Maestro notificado |
| C14 | 🤓 Gafas | Patrón de ambigüedad recurrente | 🩺 Bug Doctor | Diagnóstico preventivo |

#### Hooks C15–C20: El Cuarteto — Los Originales invocan a Las Manos

| # | Inicia | Gatillo | Invoca a | Resultado |
|---|--------|---------|----------|-----------|
| C15 | 🧪 Maestro | Feature necesita deploy, no hay pipeline | 🖐️ Manos | Pipeline CI/CD + variables saneadas |
| C16 | 🧪 Maestro | Variables de entorno inconsistentes | 🖐️ Manos | `.env.example` alineado con código |
| C17 | 🩺 Bug Doctor | Necesita staging para reproducir bug | 🖐️ Manos | Entorno efímero que replica producción |
| C18 | 🩺 Bug Doctor | Bug de seguridad (secretos, CVEs) | 🖐️ Manos | Blindaje inmediato + rotación |
| C19 | 🤓 Gafas | ADR necesita restricciones de infra | 🖐️ Manos | Contexto operacional para el ADR |
| C20 | 🤓 Gafas | Secretos en documentación de dominio | 🖐️ Manos | Limpieza + prevención de leaks |

### Lógica especializada absorbida

Cada agente principal integra la lógica de sus especialidades sin necesidad de sub-agentes:

| Agente | Skills absorbidas |
|--------|-------------------|
| 🤓 **El de las Gafas** | ddd-strategic-design (subdominios), ddd-context-mapping (patrones bounded context), improve-codebase-architecture (deepening) |
| 🖐️ **Las Manos** | senior-devops (CI/CD, Docker, IaC), dependency-auditor (CVEs, licencias), env-secrets-manager (.env, leaks), incident-commander (SEV-0→3), git-worktree-manager, skill-security-auditor, git-guardrails, setup-pre-commit |

### Ciclos compuestos — cuando los 20 hooks se encadenan

#### 🐛🔍 "Bug revela deuda de dominio" (C7→C11→C10→C14)

```
C7: Bug Doctor → Gafas ("¿este bug es malentendido del dominio?")
 ↓
C11: Gafas → Bug Doctor ("sí, el código contradice el glosario")
 ↓
C10: Bug Doctor → Gafas ("autopsia: documenta esto en CONTEXT.md")
 ↓
C14: Gafas → Bug Doctor ("hay patrón de ambigüedad en 3 módulos")
```

#### 🧪🤓 "Feature con validación de dominio" (C2→C12→C5→C13)

```
C2/C3/C4: Maestro → Gafas ("clarifica / revisa diseño / valida alto riesgo")
 ↓
C12: Gafas → Maestro ("esa regla de dominio no tiene tests. Blíndala con TDD")
 ↓
C5: Maestro → Gafas ("código listo, ¿el naming respeta el glosario?")
 ↓
C13: Gafas → Maestro ("creé ADR-000X. Consúltalo en futuras features")
```

#### 🖐️🚀 "Deploy con garantías" (C15→Manos→C16)
Las Manos ejecuta internamente su lógica de CI/CD, secretos y dependencias:

```
C15: Maestro → Manos ("necesito pipeline para deployar esta feature")
  ↓
Las Manos activa sus modos: CI/CD → Secretos → Dependencias
  ↓
C16: Manos → Maestro ("entorno listo, deploy verificado")
```

#### 🔒🛡️ "Incidente de seguridad" (C18→Manos→incidente)
Las Manos ejecuta internamente su lógica de respuesta a incidentes:

```
C18: Bug Doctor → Manos ("¡secreto expuesto en el código!")
  ↓
Las Manos activa sus modos: Incidentes (SEV-1) → Secretos (rotación) → Guardrails
  ↓
Manos → Bug Doctor ("incidente mitigado, post-mortem documentado")
```

### 🚨 Delegación obligatoria

Cada agente tiene reglas duras de delegación — no sugerencias, sino checkpoints obligatorios:

| Agente | Regla | Disparador |
|--------|-------|------------|
| 🧪 Maestro | → Gafas | Risk ≥ 60 en INIT |
| 🧪 Maestro | → Bug Doctor | ≥ 3 hipótesis en diagnóstico |
| 🧪 Maestro | → Manos | Entorno de testing no verificado |
| 🩺 Bug Doctor | → Maestro | Fix identificado (Fase 5) |
| 🩺 Bug Doctor | → Gafas | Hipótesis toca dominio |
| 🩺 Bug Doctor | → Manos | Falta tooling de diagnóstico |
| 🤓 Gafas | → Bug Doctor | Código ≠ docs |
| 🤓 Gafas | → Maestro | Término clarificado / ADR creado |
| 🖐️ Manos | → Maestro | Entorno listo |
| 🖐️ Manos | → Bug Doctor | Fallo de sistema/runtime |
| 🖐️ Manos | → Gafas | Tooling afecta al equipo |

---

## Estructura de Archivos

```
tu-proyecto/
├── .opencode/
│   ├── agents/              # Agentes del cuarteto
│   │   ├── el-maestro.md
│   │   ├── bug-doctor.md
│   │   ├── el-de-las-gafas.md
│   │   └── las-manos.md
│   └── skills/              # Skills (32 especialidades)
│       ├── el-maestro/SKILL.md
│       ├── bug-doctor/SKILL.md
│       ├── el-de-las-gafas/SKILL.md
│       ├── las-manos/SKILL.md
│       ├── ddd-context-mapping/SKILL.md
│       ├── ddd-strategic-design/SKILL.md
│       ├── improve-codebase-architecture/SKILL.md
│       ├── senior-devops/SKILL.md
│       ├── dependency-auditor/SKILL.md
│       ├── env-secrets-manager/SKILL.md
│       ├── incident-commander/SKILL.md
│       ├── git-worktree-manager/SKILL.md
│       ├── skill-security-auditor/SKILL.md
│       ├── git-guardrails/SKILL.md
│       ├── setup-pre-commit/SKILL.md
│       └── ... (17 skills genéricas complementarias)
├── opencode.json
└── README.md
```

---

## Skills Complementarias (28)

Además de las 4 skills principales de ETC, este repo incluye 28 skills especializadas y complementarias:

### Skills Genéricas y de Soporte (17)

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

### Skills Especializadas de Dominio y Operaciones (11)

Estas skills están absorbidas como modos internos de El de las Gafas y Las Manos:

| Skill | Especialidad | Absorbida por |
|-------|-------------|---------------|
| `ddd-strategic-design` | Clasificación de subdominios (Core/Supporting/Generic) | 🤓 El de las Gafas |
| `ddd-context-mapping` | Patrones formales de bounded context | 🤓 El de las Gafas |
| `improve-codebase-architecture` | Deepening arquitectónico | 🤓 El de las Gafas |
| `senior-devops` | CI/CD, Docker, Infraestructura como Código | 🖐️ Las Manos |
| `dependency-auditor` | Auditoría de CVEs, licencias, versiones | 🖐️ Las Manos |
| `env-secrets-manager` | Gestión de .env, rotación, detección de leaks | 🖐️ Las Manos |
| `incident-commander` | Respuesta a incidentes (SEV-0→3) | 🖐️ Las Manos |
| `git-worktree-manager` | Worktrees para entornos paralelos | 🖐️ Las Manos |
| `skill-security-auditor` | Auditoría de skills de terceros | 🖐️ Las Manos |
| `git-guardrails` | Pre-commit hooks de seguridad | 🖐️ Las Manos |
| `setup-pre-commit` | Instalación y configuración de pre-commit | 🖐️ Las Manos |

**Total: 4 agentes principales con lógica especializada absorbida + 32 skills (4 de agentes + 28 complementarias).**

---

## Formato de los Archivos

### Skill: `SKILL.md`

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

### Agent: `.md` con frontmatter

```yaml
---
description: Descripción de cuándo usar este agente
mode: subagent
---

# Nombre del Agente

Instrucciones completas de personalidad, misión, reglas y flujo de trabajo...
```

---

## Cómo se Usan

| Método | Sintaxis | Aplica a | Ejemplo |
|--------|----------|----------|---------|
| **@mención** | `@las-manos` | Agents | `@las-manos configura CI/CD` |
| **/comando** | `/las-manos` | Skills y Agents | `/skill-security-auditor` `/setup-pre-commit` |
| **Lenguaje natural** | Describir la tarea | Skills | "Necesito auditar las dependencias" |

---

## Cómo Replicar Esto en Tu Proyecto

```bash
# Clonar este repo
git clone <this-repo> /tmp/etc-cuarteto

# Copiar agents y skills a tu proyecto
cp /tmp/etc-cuarteto/.opencode/agents/* tu-proyecto/.opencode/agents/
cp -r /tmp/etc-cuarteto/.opencode/skills/* tu-proyecto/.opencode/skills/

# (Opcional) Disponibilidad global
cp /tmp/etc-cuarteto/.opencode/agents/* ~/.config/opencode/agents/
cp -r /tmp/etc-cuarteto/.opencode/skills/* ~/.config/opencode/skills/
```

Luego en OpenCode:

```
@el-maestro implementa login con JWT
@bug-doctor diagnostica el error 500 intermitente
@el-de-las-gafas revisa mi modelo de dominio
@las-manos configura el pipeline de CI/CD
```

---

## 📦 Releases

### v1.0.0 — El Cuarteto Calavera (2026-05-08)

Primera release estable del Cuarteto Calavera:
- 🧪 **El Maestro** — TDD Orchestrator con ciclo completo INIT→PLAN→RED→GREEN→REFACTOR→REVIEW→COMMIT
- 🩺 **Bug Doctor** — Diagnóstico forense de 6 fases con principio de repro determinista
- 🤓 **El de las Gafas** — Domain Moderator con DDD, context mapping, y deepening arquitectónico
- 🖐️ **Las Manos** — Infrastructure & Ops con CI/CD, secretos, dependencias, incidentes y Modo Integración de APIs
- **20 hooks de colaboración** (C1–C20) entre los 4 agentes
- **11 reglas de delegación obligatoria** — checkpoints estrictos que garantizan calidad
- **32 skills** en `.opencode/skills/` (4 de agentes + 28 complementarias)
- **Modo Integración de APIs** en Las Manos: Supabase, Google OAuth, Stripe, GitHub, AWS

---

## Licencia

MIT — heredada de [morodomi/tdd-skills](https://github.com/morodomi/tdd-skills), [mattpocock/skills](https://github.com/mattpocock/skills), y [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills).
