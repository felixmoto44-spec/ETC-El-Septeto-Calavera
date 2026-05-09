# Changelog — ETC: El Septeto Calavera

Todos los cambios notables se documentan en este fichero.

---

## [2.1.0] — 2026-05-09 — El Árbitro

### Agente nuevo
- ⚖️ **El Árbitro** — Conflict Resolution Agent. Resuelve disputas entre agentes aplicando el protocolo de conflictos.

### Hooks nuevos
- **C44:** performance benchmarking (El Maestro)
- **C51–C53:** arbitraje de conflictos y documentación de precedentes
- **Total: 53 hooks** (C1–C53)

### Nuevas skills
- `el-arbitro/SKILL.md`
- **Total: 35 skills** (7 de agentes + 28 complementarias)

### Modificado
- Los 6 agentes existentes ahora invocan a El Árbitro (C51) ante conflictos
- README.md: El Sexteto → El Septeto Calavera (7 agentes, 35 skills, 53 hooks, 29 reglas)
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
