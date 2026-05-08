# Protocolo de resolución de conflictos entre agentes

## Principio fundamental

Cada agente tiene soberanía en su dominio. Los conflictos ocurren cuando dos dominios se solapan. Este documento define quién tiene la última palabra en cada tipo de conflicto.

## Tabla de soberanía por dominio

| Dominio | Agente soberano | Razón |
|---------|----------------|-------|
| Ciclo TDD, cobertura, tests | 🧪 El Maestro | Orchestrator del ciclo |
| Ubiquitous language, glosario | 🤓 El de las Gafas | Domain Moderator |
| Causa raíz de bugs | 🩺 Bug Doctor | Método forense |
| Infraestructura, secretos, CI/CD | 🖐️ Las Manos | Ops Specialist |
| Diseño visual, UX, accesibilidad | 🎨 El Pintor | Frontend Expert |
| API contracts, schemas, auth | ⚒️ El Herrero | Backend Expert |

## Conflictos conocidos y su resolución

### Conflicto 1: ¿Quién decide el contrato de API?

**Situación:** El Pintor quiere un endpoint con cierta estructura. El Herrero propone una estructura diferente.

**Resolución:** El Herrero decide el contrato técnico. El Pintor puede proponer requisitos funcionales (qué datos necesita la UI), pero el diseño del endpoint (ruta, estructura, errores) es soberanía del Herrero.

**Si no hay acuerdo:** El Herrero documenta las dos opciones y las eleva al usuario. No implementa ni una ni otra sin decisión explícita.

---

### Conflicto 2: ¿El Maestro puede cambiar código de dominio?

**Situación:** El Maestro, en fase GREEN, refactoriza un nombre de método que no coincide con el glosario de Gafas.

**Resolución:** Gafas tiene veto sobre naming de dominio. El Maestro debe invocar a Gafas (hook C5) antes de renombrar entidades de dominio, incluso si el cambio parece puramente técnico.

---

### Conflicto 3: ¿Bug Doctor o El Herrero diagnostica un bug de DB?

**Situación:** Hay un deadlock en la base de datos. ¿Lo diagnostica Bug Doctor (método forense) o El Herrero (experto en DB)?

**Resolución:** Bug Doctor lidera el diagnóstico (es el forense). El Herrero actúa como especialista consultado (hook C33). El fix lo implementa El Maestro (hook C9), con diseño de El Herrero.

**Regla general:** Bug Doctor siempre lidera el diagnóstico. Los demás agentes aportan conocimiento especializado pero no sustituyen el método forense.

---

### Conflicto 4: ¿Qué pasa si el risk score del Maestro y la evaluación de Gafas difieren?

**Situación:** El Maestro calcula risk score 55 (PROCEED). Gafas, al revisar, considera que el riesgo es mayor.

**Resolución:** Gafas tiene veto de dominio. Si Gafas eleva el riesgo a BLOCK, el ciclo TDD no continúa. El desacuerdo se documenta como ADR con la decisión final.

---

## Protocolo de escalación

Si un conflicto no encaja en los casos anteriores:

1. **Parar:** ningún agente implementa nada mientras el conflicto no esté resuelto
2. **Documentar:** el agente que detecta el conflicto lo documenta en el chat
3. **Elevar al usuario:** presentar las dos opciones con pros/contras
4. **Decisión del usuario:** el usuario decide y el agente afectado crea un ADR
5. **No hay conflicto eterno:** si el usuario no responde en la misma sesión, el agente con soberanía en el dominio más directamente afectado decide con la opción más conservadora

## Señales de conflicto que los agentes deben reconocer

- "Yo haría X, pero [Agente] sugirió Y" → conflicto detectado, escalar
- Un agente implementa algo que es dominio de otro → parar y derivar
- Dos agentes proponen soluciones contradictorias sin resolverlo → escalar al usuario
