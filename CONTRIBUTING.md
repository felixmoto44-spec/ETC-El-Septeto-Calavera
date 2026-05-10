# Contribuir a ETC — El Septeto Calavera

¡Bienvenido! Este documento explica cómo añadir agentes, skills, o proponer nuevos hooks.

## Antes de contribuir

1. Lee el README completo para entender la arquitectura del septeto
2. Asegúrate de que tu contribución no duplica funcionalidad existente
3. Abre un Issue primero para discutir cambios grandes

## Cómo añadir un nuevo agente

Un agente nuevo debe justificarse como un rol que:
- No está cubierto por ninguno de los 7 agentes actuales
- Tiene un conjunto de responsabilidades cohesivo y delimitado
- Puede colaborar con el septeto mediante hooks documentados

### Plantilla de agente

Crea `.opencode/agents/nombre-del-agente.md`:

```markdown
---
description: >
  Descripción de cuándo usar este agente (2-3 frases).
  Qué problemas resuelve y cuándo invocarlo.
mode: subagent
---

# 🎭 Nombre del Agente — Rol Principal

> *"Frase característica del personaje."*

## Identidad

**Personaje:** [Descripción del personaje y su personalidad]
**Misión:** [Una frase que resume su propósito]
**Principio fundamental:** [La regla de oro que nunca rompe]

## Responsabilidades

[Lista de qué hace este agente]

## Lo que NO hace este agente

[Lista explícita de lo que está fuera de su scope]

## Flujo de trabajo

[Descripción paso a paso de cómo trabaja]

## Hooks de colaboración

| Hook | Gatillo | Invoca a | Resultado |
|------|---------|----------|-----------|
| CXX | [condición] | [agente] | [qué pasa] |

## Reglas de delegación obligatoria

- **→ [Agente]** cuando [condición]
```

### Checklist antes de hacer PR con un agente nuevo

- [ ] El agente tiene frontmatter correcto (`description` y `mode: subagent`)
- [ ] El agente tiene sección "Lo que NO hace" para delimitar su scope
- [ ] Los hooks están documentados con número CXX (siguiendo la numeración)
- [ ] Los hooks están añadidos al README en las tablas correspondientes
- [ ] El agente está añadido al `opencode.json` en la allowlist
- [ ] El agente está añadido a la sección "Lógica especializada absorbida" si procede
- [ ] Se ha añadido al menos un test de hook en `tests/hooks.md`
- [ ] Se ha actualizado la tabla de delegación obligatoria en el README

---

## Cómo añadir una nueva skill

### Cuándo crear una skill vs ampliar un agente existente

| Caso | Decisión |
|------|----------|
| La skill es una especialidad puntual reutilizable | Crear skill independiente |
| La skill define el comportamiento central de un agente | Absorberla en el agente |
| La skill necesita estado o contexto propio | Crear skill independiente |
| La skill complementa a varios agentes | Crear skill independiente |

### Plantilla de skill

Crea `.opencode/skills/nombre-skill/SKILL.md`:

```markdown
---
name: nombre-de-la-skill
description: >
  Descripción de qué hace y cuándo usarla.
  Usa palabras clave que faciliten su invocación por lenguaje natural.
license: MIT
compatibility: opencode
version: 1.0.0
---

# Nombre de la Skill

## Objetivo

[Una párrafo explicando el propósito de la skill]

## Cuándo usar esta skill

[Lista de situaciones donde esta skill es la herramienta correcta]

## Cuándo NO usar esta skill

[Lista de situaciones donde otra skill o agente es más apropiado]

## Cómo funciona

[Descripción del flujo de trabajo o proceso]

## Output esperado

[Qué produce esta skill al ejecutarse]
```

### Política de herramientas

Si contribuyes con una skill que requiere herramientas externas, prioriza herramientas que sean **gratuitas, nativas del sistema, y sin necesidad de API keys**. Esto asegura que cualquier usuario pueda usar la skill inmediatamente sin configuraciones ni costes adicionales.

Si la herramienta óptima requiere API key (ej. firecrawl, servicios SaaS), documéntalo explícitamente como alternativa opcional y provee siempre un método gratuito alternativo.

### Checklist antes de hacer PR con una skill nueva

- [ ] El frontmatter tiene `name`, `description`, `license` y `compatibility`
- [ ] La descripción menciona explícitamente cuándo invocarla
- [ ] La skill tiene sección "Cuándo NO usar" para evitar solapamiento
- [ ] La skill usa herramientas gratuitas y nativas del sistema siempre que sea posible
- [ ] Si requiere API key, está documentado como opcional y hay alternativa gratuita
- [ ] La skill está añadida al `opencode.json` en la allowlist
- [ ] La skill está listada en la tabla del README en la sección correcta

---

## Cómo proponer un nuevo hook

### Criterios de un buen hook

1. **Es obligatorio, no opcional** — el agente siempre debe derivar en ese caso
2. **Tiene un disparador claro** — se puede describir en una frase sin ambigüedad
3. **Produce un resultado concreto** — se sabe exactamente qué pasa después
4. **No duplica un hook existente** — revisa la tabla C1–C46, C54–C56 antes de proponer

### Plantilla de propuesta de hook

Abre un Issue con el título: `[Hook] CXX: AgentA → AgentB — descripción breve`

```markdown
## Hook propuesto: CXX

**De:** [Agente que inicia]
**A:** [Agente que recibe]
**Número:** CXX (siguiente disponible)

### Disparador
[Descripción exacta de la condición que activa el hook]

### Por qué es obligatorio
[Justificación de por qué el agente NO debe manejarlo solo]

### Resultado esperado
[Qué produce el agente receptor]

### Ejemplo concreto
[Input de usuario que dispararía este hook]
```

---

## Proceso de PR

1. Fork del repositorio
2. Rama con nombre descriptivo: `feat/agente-el-arbitro` o `fix/hook-c15-contexto`
3. Commits en conventional commits: `feat:`, `fix:`, `docs:`, `chore:`
4. PR con descripción que incluya: qué añade, por qué, cómo probarlo
5. El PR debe pasar las GitHub Actions de validación de estructura

## Código de conducta

Mantén el espíritu del septeto: cada agente tiene su rol, cada contribución tiene su lugar. Si no sabes dónde encaja algo, abre un Issue primero.
