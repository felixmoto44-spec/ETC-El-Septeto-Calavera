# Changelog — ETC: El Septeto Calavera

Todos los cambios notables se documentan en este fichero.

---

## [3.0.0] — 2026-05-09 — Integración ETC + Superpowers

### Añadido — Metodología Superpowers (7 skills)

| Skill | Asignada a | Propósito |
|---|---|---|
| `brainstorming` | ⚖️ Supervisor | Refinar ideas antes de escribir código |
| `writing-plans` | 🤓 El de las Gafas | Convertir design doc en plan accionable |
| `using-git-worktrees` | 🖐️ Las Manos | Workspace aislado antes de implementar |
| `subagent-driven-development` | ⚖️ Supervisor | Orquestar subagentes frescos por tarea |
| `test-driven-development` | 🧪 El Maestro | Ciclo RED→GREEN→REFACTOR obligatorio |
| `requesting-code-review` | ⚖️ El Árbitro | Revisión 2 etapas (spec + calidad) |
| `finishing-a-development-branch` | 🖐️ Las Manos | Cerrar rama, limpiar worktree, merge/PR |

### Añadido — Protocolo de comunicación
- **4 hooks nuevos**: S-W1 (worktree), C-P1 (planificar), C-R1 (code review), S-W2 (cerrar rama)
- **Protocolo de status**: DONE / DONE_WITH_CONCERNS / BLOCKED / NEEDS_CONTEXT
- `docs/plans/` — directorio para design docs y planes de implementación

### Skills totales
- **46 skills** (7 de agentes + 32 complementarias + 7 de metodología Superpowers)

### Infraestructura
- `opencode.json` actualizado con allowlist para las 7 nuevas skills

---

## [2.3.0] — 2026-05-09 — Protocolo de Handoff con Auditoría

### Añadido
- 📋 Hook C56 en los 7 agentes: Protocolo de Handoff con Auditoría
- Cada agente ahora: recibe → delega al especialista → espera → **audita** el resultado → presenta
- Regla de responsabilidad: el agente que delega es dueño del resultado hasta que el usuario lo aprueba

### Modificado
- Los 7 agentes: nueva sección "Protocolo de Handoff con Auditoría" después de Reglas de Delegación
- README.md: 50 hooks totales (C1–C46, C54–C56)

### Total
- **50 hooks** (C1–C46, C54–C56)
- **39 skills** (7 de agentes + 32 complementarias)
- **7 agentes**

---

## [2.2.0] — 2026-05-09 — Investigación Web Centralizada

### Añadido
- 🔍 Hook C54: todos los agentes delegan búsquedas web a El de las Gafas
- 🔍 Modo Investigación Web en El de las Gafas (multicanal: docs, GitHub, SO, foros, source)
- 📚 3 skills nuevas: github-research, stackoverflow-research, docs-verifier
- Hook C55: auto-documentación de hallazgos de investigación como mini-ADR
- Regla de delegación dura: "DEBES invocar a Gafas para búsquedas web"

### Modificado
- Los 6 agentes existentes: añadido hook C54 + regla de delegación
- README.md: 49 hooks, 38 skills, nueva sección C54–C55

### Total
- 49 hooks (C1–C46, C54–C55)
- 38 skills (7 de agentes + 31 complementarias)

---

## [2.1.0] — 2026-05-09 — El Árbitro

### Agente nuevo
- ⚖️ **El Árbitro** — Conflict Resolution Agent. Resuelve disputas entre agentes aplicando el protocolo de conflictos.

### Hooks nuevos
- **C44:** invoca /performance-benchmarker (skill externa, no agente)
- **C51–C53:** arbitraje de conflictos y documentación de precedentes (3 hooks entre agentes)
- **Total: 46 hooks** (C1–C43, C51–C53)

### Nuevas skills
- `el-arbitro/SKILL.md`
- **Total: 35 skills** (7 de agentes + 28 complementarias)

### Modificado
- Los 6 agentes existentes ahora invocan a El Árbitro (C51) ante conflictos
- README.md: El Sexteto → El Septeto Calavera (7 agentes, 35 skills, 46 hooks, 29 reglas)
- `docs/conflict-resolution.md`: añadida referencia a El Árbitro como implementador del protocolo

### Infraestructura
- `opencode.json` con allowlist actualizada (+ `el-arbitro`)
- Agente y skill sincronizados a `~/.config/opencode/`

---

## [2.0.0] — 2026-05-09 — El Sexteto Calavera

### Agentes nuevos
- 🎨 **El Pintor** — Frontend Expert. 5 modos: Inspiración, Animación, Performance, Accesibilidad, Prototipado Rápido
- ⚒️ **El Herrero** — Backend Expert. 7 modos: API Design, Database, Auth, Arquitectura, Serverless, Seguridad, Performance

### Hooks nuevos
- **C24–C29:** 6 hooks del Pintor con el resto del sexteto
- **C30–C35:** 6 hooks del Herrero con el resto del sexteto
- **C36–C43:** 8 hooks de los agentes originales invocando a Pintor y Herrero

### Skills
- `el-pintor/SKILL.md` y `el-herrero/SKILL.md`
- **Total: 34 skills** (6 de agentes + 28 complementarias)

### Seguridad
- `opencode.json` con allowlist explícita + `"*": "deny"`

---

## [1.0.0] — 2026-05-08 — El Cuarteto Calavera

### Agentes
- 🧪 **El Maestro** — TDD Orchestrator
- 🩺 **Bug Doctor** — Diagnóstico Forense
- 🤓 **El de las Gafas** — Domain Moderator + DDD
- 🖐️ **Las Manos** — Infrastructure & Operations

### Hooks
- **C1–C14:** Trío original (Maestro ↔ Bug Doctor ↔ Gafas)
- **C15–C20:** Originales invocan a Las Manos
- **C21–C23:** Gafas profundiza arquitectura

### Delegación obligatoria
- 11 reglas duras (DEBES en vez de considera)

### Modo especial
- **Integración de APIs** en Las Manos (Supabase, Google OAuth, Stripe, GitHub, AWS)

### Infraestructura
- `opencode.json`, `.github/workflows/`, 32 skills, README completo

---

## Origen

- Skills de El Maestro y Bug Doctor: [morodomi/tdd-skills](https://github.com/morodomi/tdd-skills)
- Skills de El de las Gafas: [mattpocock/skills](https://github.com/mattpocock/skills)
- Inspiración para Las Manos: [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills)
- El Pintor y El Herrero: diseñados desde cero para ETC
