# ETC — El Trío Calavera / Cuarteto / Sexteto (Histórico)

> ⚠️ **Repositorio histórico.** Este subdirectorio contiene las versiones v1.0.0 y v2.0.0
> del proyecto, cuando se llamaba "El Trío Calavera" (3 agentes), "El Cuarteto Calavera"
> (4 agentes) o "El Sexteto Calavera" (6 agentes). Se conserva como referencia histórica.
>
> La versión actual del proyecto es **ETC — El Septeto Calavera** (7 agentes),
> ubicada en el directorio raíz. Para el ecosistema completo de 14 agentes,
> instala también [ETC-System-Agents](https://github.com/felixmoto44-spec/ETC-System-Agents).

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

### 🎨 El Pintor — Frontend Expert

Artista digital del equipo. Diseña interfaces espectaculares con React, CSS moderno, y animaciones fluidas (GSAP, Framer Motion, Three.js). Optimiza Core Web Vitals (LCP, INP, CLS), audita accesibilidad WCAG 2.1 AA, construye PWAs con capacidades offline, y prototipa en horas. Conoce dónde buscar inspiración (CodePen, Dribbble, Animista, Rive) y sabe cuándo usar CSS nativo vs una librería.

Incluye 5 modos especiales: **Inspiración** (referencias visuales), **Animación** (diseño e implementación), **Performance** (Core Web Vitals), **Accesibilidad** (WCAG 2.1 AA completa), y **Prototipado Rápido** (del wireframe al prototipo funcional).

**Origen**: Diseñado desde cero para ETC, absorbiendo `frontend-developer`, `accessibility-auditor`, `rapid-prototyper`, más conocimiento propio de animaciones, performance, PWA, y CSS moderno.

### ⚒️ El Herrero — Backend Expert

Forjador de sistemas del equipo. Diseña APIs robustas (REST/GraphQL/tRPC), modela bases de datos (PostgreSQL/Supabase con RLS, índices, migraciones), implementa autenticación (OAuth 2.0/OIDC, JWT, RBAC/ABAC), y aplica patrones de arquitectura (Hexagonal, CQRS, Event Sourcing, Modular Monolith). Optimiza queries con EXPLAIN ANALYZE, caching (Redis/Upstash), hunting de N+1, y audita seguridad (OWASP Top 10, rate limiting).

Incluye 7 modos especiales: **API Design**, **Database** (schema, migraciones, índices), **Auth** (OAuth/OIDC), **Arquitectura** (patrones), **Serverless** (Vercel/Cloudflare edge), **Seguridad** (OWASP + hardening), y **Performance** (query optimization + caching).

**Origen**: Diseñado desde cero para ETC, absorbiendo `backend-architect`, `database-optimizer`, `api-tester`, `security-engineer`, más conocimiento propio de tRPC, OAuth 2.0, CQRS, caching, y message queues.

---

## 🤝 Colaboración entre Agentes

Los 6 agentes de ETC no trabajan en aislamiento — se invocan entre sí automáticamente según el contexto. Hay **43 hooks de colaboración** (C1–C43) documentados en sus instrucciones, y cada agente integra internamente la lógica de sus especialidades.

> _«El Maestro implementa, Bug Doctor diagnostica, El de las Gafas clarifica, Las Manos despliega, El Pintor da vida al frontend, El Herrero forja el backend. El que calla una duda al compañero, la paga con un bug.»_

### El patrón: Implementar → Diagnosticar → Clarificar → Desplegar

Cada agente tiene un rol primario claro, y cuando detecta que está fuera de su especialidad, deriva al colega adecuado:

| Agente | Rol primario | Deriva a... |
|--------|-------------|-------------|
| 🧪 **El Maestro** | Implementar features y fixes con TDD | 🤓 Gafas (dominio), 🩺 Bug Doctor (bugs), 🖐️ Manos (deploy/env), 🎨 Pintor (frontend), ⚒️ Herrero (backend) |
| 🩺 **Bug Doctor** | Diagnosticar causa raíz de bugs | 🧪 Maestro (implementar fix), 🤓 Gafas (deuda de dominio), 🖐️ Manos (entorno/seguridad), 🎨 Pintor (bugs visuales), ⚒️ Herrero (bugs de datos) |
| 🤓 **El de las Gafas** | Clarificar ubiquitous language y documentación | 🧪 Maestro (blindar con tests), 🩺 Bug Doctor (bugs por ambigüedad), 🖐️ Manos (infra/secretos), 🎨 Pintor (patrones UI → ADR), ⚒️ Herrero (modelos de datos → CONTEXT) |
| 🖐️ **Las Manos** | Infraestructura, CI/CD, secretos, dependencias, incidentes, worktrees, auditoría de skills | 🧪 Maestro (deploy feature), 🩺 Bug Doctor (incidentes), 🤓 Gafas (ADR operacionales), 🎨 Pintor (deps frontend), ⚒️ Herrero (infra backend) |
| 🎨 **El Pintor** | Diseño visual, animaciones, performance frontend, accesibilidad, prototipado | 🧪 Maestro (implementar UI con TDD), 🖐️ Manos (dependencias), 🤓 Gafas (ADR de diseño), 🩺 Bug Doctor (bugs visuales), ⚒️ Herrero (contratos de API) |
| ⚒️ **El Herrero** | APIs, schemas, auth, arquitectura, caching, seguridad | 🧪 Maestro (implementar con TDD), 🖐️ Manos (infraestructura), 🤓 Gafas (modelo de dominio), 🩺 Bug Doctor (bugs de datos), 🎨 Pintor (contratos de API) |

### Los 43 hooks de colaboración (C1–C43)

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

#### Hooks C21–C23: Gafas profundiza la arquitectura

| # | Inicia | Gatillo | Invoca a | Resultado |
|---|--------|---------|----------|-----------|
| C21 | 🤓 Gafas | Subdominio Core sin tests ni inversión | 🧪 Maestro | Ciclo de deepening con TDD |
| C22 | 🤓 Gafas | Módulo shallow con bugs frecuentes | 🩺 Bug Doctor | Diagnóstico en paralelo |
| C23 | 🤓 Gafas | Nuevo bounded context descubierto | 🧪 Maestro | Mapa de contextos actualizado |

#### Hooks C24–C29: El Pintor — Frontend Expert

| # | Inicia | Gatillo | Invoca a | Resultado |
|---|--------|---------|----------|-----------|
| C24 | 🎨 Pintor | Componente/UI listo para implementación | 🧪 Maestro | Ciclo TDD del componente con contrato visual |
| C25 | 🎨 Pintor | Diseño requiere nuevas dependencias | 🖐️ Manos | Dependencias auditadas e instaladas |
| C26 | 🎨 Pintor | Patrón de UI reutilizable creado | 🤓 Gafas | Evaluación de ADR de diseño |
| C27 | 🎨 Pintor | Bug visual o de renderizado | 🩺 Bug Doctor | Diagnóstico forense del bug visual |
| C28 | 🎨 Pintor | Necesita endpoint de API para la UI | ⚒️ Herrero | Contrato de API diseñado |
| C29 | 🎨 Pintor | UI toca conceptos del dominio | 🤓 Gafas | Verificación de ubiquitous language |

#### Hooks C30–C35: El Herrero — Backend Expert

| # | Inicia | Gatillo | Invoca a | Resultado |
|---|--------|---------|----------|-----------|
| C30 | ⚒️ Herrero | API endpoint modelado y listo | 🧪 Maestro | Ciclo TDD del endpoint con contrato |
| C31 | ⚒️ Herrero | Necesita infraestructura (DB, Redis, queues) | 🖐️ Manos | Infraestructura provisionada y verificada |
| C32 | ⚒️ Herrero | Modelo de datos toca el dominio | 🤓 Gafas | Ubiquitous language verificado en schema |
| C33 | ⚒️ Herrero | Race condition, deadlock o bug de datos | 🩺 Bug Doctor | Diagnóstico forense del bug de datos |
| C34 | ⚒️ Herrero | Endpoint listo, contrato de API final | 🎨 Pintor | Frontend informado del contrato |
| C35 | ⚒️ Herrero | Migración lista para staging/prod | 🖐️ Manos | Migración ejecutada con plan de rollback |

#### Hooks C36–C43: Los Originales invocan a Pintor y Herrero

| # | Inicia | Gatillo | Invoca a | Resultado |
|---|--------|---------|----------|-----------|
| C36 | 🧪 Maestro | Feature con scope frontend | 🎨 Pintor | Diseño visual + contrato de UI |
| C37 | 🧪 Maestro | Feature con scope backend | ⚒️ Herrero | Diseño API/DB + contrato de endpoint |
| C38 | 🩺 Bug Doctor | Bug de renderizado/visual | 🎨 Pintor | Revisión del componente afectado |
| C39 | 🩺 Bug Doctor | Bug de datos/DB/race condition | ⚒️ Herrero | Revisión del schema/query afectado |
| C40 | 🤓 Gafas | Patrón de UI para documentar | 🎨 Pintor | ADR de diseño registrado |
| C41 | 🤓 Gafas | Modelo de datos para documentar | ⚒️ Herrero | CONTEXT.md actualizado |
| C42 | 🖐️ Manos | Dependencias frontend instaladas | 🎨 Pintor | Dependencias listas para usar |
| C43 | 🖐️ Manos | Infraestructura backend provisionada | ⚒️ Herrero | Infraestructura lista para usar |

### Lógica especializada absorbida

Cada agente principal integra la lógica de sus especialidades sin necesidad de sub-agentes:

| Agente | Skills absorbidas |
|--------|-------------------|
| 🤓 **El de las Gafas** | ddd-strategic-design (subdominios), ddd-context-mapping (patrones bounded context), improve-codebase-architecture (deepening) |
| 🖐️ **Las Manos** | senior-devops (CI/CD, Docker, IaC), dependency-auditor (CVEs, licencias), env-secrets-manager (.env, leaks), incident-commander (SEV-0→3), git-worktree-manager, skill-security-auditor, git-guardrails, setup-pre-commit |
| 🎨 **El Pintor** | frontend-developer (React/Vue/Angular), accessibility-auditor (WCAG), rapid-prototyper (MVPs), más conocimiento propio de animaciones (GSAP, Framer Motion, Three.js), performance (Core Web Vitals), PWA, y CSS moderno |
| ⚒️ **El Herrero** | backend-architect (sistemas escalables), database-optimizer (PostgreSQL/Supabase), api-tester (validación), security-engineer (OWASP), más conocimiento propio de tRPC, OAuth 2.0/OIDC, CQRS/Event Sourcing, caching, y message queues |

### Ciclos compuestos — cuando los 23 hooks se encadenan

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

#### 🎨⚒️ "Full-stack feature con contrato" (C37→C34→C24→C30)

```
C37: Maestro → Herrero ("feature backend: diseñá el endpoint")
  ↓
C34: Herrero → Pintor ("endpoint listo: aquí el contrato de API")
  ↓
C24: Pintor → Maestro ("UI diseñada: implementala con TDD")
  ↓
C30: Herrero → Maestro ("endpoint diseñado: implementalo con TDD")
  ↓
Maestro ejecuta ciclos TDD en paralelo (frontend + backend)
```

#### 🎨🤓 "De la UI al ADR de diseño" (C26→C40)

```
C26: Pintor → Gafas ("creé un patrón de UI reutilizable, ¿lo documento?")
  ↓
C40: Gafas → Pintor ("sí, lo registro como ADR de diseño")
```

### 🚨 Delegación obligatoria

Cada agente tiene reglas duras de delegación — no sugerencias, sino checkpoints obligatorios:

| Agente | Regla | Disparador |
|--------|-------|------------|
| 🧪 Maestro | → Gafas | Risk ≥ 60 en INIT |
| 🧪 Maestro | → Bug Doctor | ≥ 3 hipótesis en diagnóstico |
| 🧪 Maestro | → Manos | Entorno de testing no verificado |
| 🧪 Maestro | → Pintor | Feature con scope frontend |
| 🧪 Maestro | → Herrero | Feature con scope backend |
| 🩺 Bug Doctor | → Maestro | Fix identificado (Fase 5) |
| 🩺 Bug Doctor | → Gafas | Hipótesis toca dominio |
| 🩺 Bug Doctor | → Manos | Falta tooling de diagnóstico |
| 🩺 Bug Doctor | → Pintor | Bug visual/de renderizado |
| 🩺 Bug Doctor | → Herrero | Bug de datos/DB/race condition |
| 🤓 Gafas | → Bug Doctor | Código ≠ docs |
| 🤓 Gafas | → Maestro | Término clarificado / ADR creado |
| 🤓 Gafas | → Pintor | Patrón de UI para ADR |
| 🤓 Gafas | → Herrero | Modelo de datos para CONTEXT |
| 🖐️ Manos | → Maestro | Entorno listo |
| 🖐️ Manos | → Bug Doctor | Fallo de sistema/runtime |
| 🖐️ Manos | → Gafas | Tooling afecta al equipo |
| 🎨 Pintor | → Maestro | Componente UI listo |
| 🎨 Pintor | → Manos | Nuevas dependencias frontend |
| 🎨 Pintor | → Gafas | UI toca dominio / patrón reusable |
| 🎨 Pintor | → Bug Doctor | Bug visual no trivial |
| 🎨 Pintor | → Herrero | Necesita contrato de API |
| ⚒️ Herrero | → Maestro | Endpoint/API listo |
| ⚒️ Herrero | → Manos | Infraestructura necesaria |
| ⚒️ Herrero | → Gafas | Diseño API/DB toca dominio |
| ⚒️ Herrero | → Bug Doctor | Race condition / bug de datos |
| ⚒️ Herrero | → Pintor | Contrato de API listo |

---

## Estructura de Archivos

```
tu-proyecto/
├── .opencode/
│   ├── agents/              # Agentes del sexteto
│   │   ├── el-maestro.md
│   │   ├── bug-doctor.md
│   │   ├── el-de-las-gafas.md
│   │   ├── las-manos.md
│   │   ├── el-pintor.md
│   │   └── el-herrero.md
│   └── skills/              # Skills (34 especialidades)
│       ├── el-maestro/SKILL.md
│       ├── bug-doctor/SKILL.md
│       ├── el-de-las-gafas/SKILL.md
│       ├── las-manos/SKILL.md
│       ├── el-pintor/SKILL.md
│       ├── el-herrero/SKILL.md
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

**Total: 6 agentes principales con lógica especializada absorbida + 34 skills (6 de agentes + 28 complementarias).**

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
@el-pintor diseña el landing page con animaciones
@el-herrero modela el schema de órdenes y pagos
```

---

## 📦 Releases

### v2.0.0 — El Sexteto Calavera (2026-05-09)

Se unen dos nuevos calaveras al equipo:
- 🎨 **El Pintor** — Frontend Expert: diseño visual, animaciones (GSAP, Framer Motion, Three.js), performance (Core Web Vitals), accesibilidad WCAG 2.1 AA, PWA, prototipado rápido. 5 modos especiales + 6 hooks de colaboración (C24–C29)
- ⚒️ **El Herrero** — Backend Expert: API design (REST/GraphQL/tRPC), database (PostgreSQL/Supabase), auth (OAuth 2.0/OIDC), arquitectura (Hexagonal, CQRS), caching, seguridad OWASP. 7 modos especiales + 6 hooks de colaboración (C30–C35)
- **8 nuevos hooks** en agentes existentes (C36–C43): Maestro, Bug Doctor, Gafas y Manos ahora colaboran con Pintor y Herrero
- **43 hooks totales** (C1–C43) entre los 6 agentes
- **26 reglas de delegación obligatoria** — 11 originales + 15 nuevas para Pintor y Herrero
- **34 skills** en `.opencode/skills/` (6 de agentes + 28 complementarias)

### v1.0.0 — El Cuarteto Calavera (2026-05-08)

Primera release estable del Cuarteto Calavera:
- 🧪 **El Maestro** — TDD Orchestrator con ciclo completo INIT→PLAN→RED→GREEN→REFACTOR→REVIEW→COMMIT
- 🩺 **Bug Doctor** — Diagnóstico forense de 6 fases con principio de repro determinista
- 🤓 **El de las Gafas** — Domain Moderator con DDD, context mapping, y deepening arquitectónico
- 🖐️ **Las Manos** — Infrastructure & Ops con CI/CD, secretos, dependencias, incidentes y Modo Integración de APIs
- **23 hooks de colaboración** (C1–C23) entre los 4 agentes
- **11 reglas de delegación obligatoria** — checkpoints estrictos que garantizan calidad
- **32 skills** en `.opencode/skills/` (4 de agentes + 28 complementarias)
- **Modo Integración de APIs** en Las Manos: Supabase, Google OAuth, Stripe, GitHub, AWS

---

## Licencia

MIT — heredada de [morodomi/tdd-skills](https://github.com/morodomi/tdd-skills), [mattpocock/skills](https://github.com/mattpocock/skills), y [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills).
