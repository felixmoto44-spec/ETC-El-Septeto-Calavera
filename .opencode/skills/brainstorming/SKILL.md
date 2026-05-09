---
name: brainstorming
description: Usar cuando el usuario quiera construir, diseñar o implementar algo nuevo, antes de escribir cualquier código o plan de implementación.
license: MIT
compatibility: opencode
---

# brainstorming

Usar cuando el usuario quiera construir, diseñar o implementar algo nuevo,
antes de escribir cualquier código o plan de implementación.

## Anuncio obligatorio

Al activar esta skill decir:
"Estoy usando la skill brainstorming para entender bien qué necesitas antes de escribir código."

## Paso 0 — Evaluar alcance antes de preguntar detalles

Antes de hacer cualquier pregunta de detalle, evaluar si el proyecto describe
múltiples subsistemas independientes (ej: "una plataforma con chat, pagos, analítica y
autenticación").

Si el proyecto es demasiado grande para un solo spec:
- Indicarlo inmediatamente al usuario.
- No gastar preguntas refinando detalles de un proyecto que primero hay que descomponer.
- Ayudar al usuario a identificar las piezas independientes y el orden en que construirlas.
- Hacer brainstorming del primer sub-proyecto con el flujo normal.
- Cada sub-proyecto tendrá su propio ciclo: spec → plan → implementación.

## Paso 1 — Explorar antes de preguntar

Antes de hacer preguntas al usuario, explorar el codebase existente:
- Invocar @el-explorador para entender la estructura actual del proyecto.
- Si hay tecnologías desconocidas, invocar @el-investigador.
- Usar ese contexto para hacer preguntas más relevantes.

## Paso 2 — Refinar la idea mediante preguntas

Para proyectos de alcance apropiado:
- Hacer preguntas de una en una.
- Preferir preguntas de opción múltiple cuando sea posible.
- Preguntas abiertas también son válidas cuando la elección requiere reflexión.
- No preguntar más de lo necesario para entender el qué, el por qué y las restricciones clave.

Áreas a cubrir (no necesariamente en este orden):
- ¿Qué problema resuelve esto y para quién?
- ¿Qué restricciones técnicas o de negocio hay?
- ¿Qué alternativas se han considerado?
- ¿Qué es lo más arriesgado o incierto del diseño?
- ¿Qué métricas indicarán que esto funciona?

## Paso 3 — Presentar el diseño en secciones

Una vez recogida suficiente información:
- Presentar el diseño en secciones cortas, una a la vez.
- Esperar confirmación o corrección antes de continuar con la siguiente sección.
- No presentar un wall of text completo de golpe.

Secciones típicas:
1. Objetivo y contexto
2. Decisiones de diseño clave
3. Componentes principales y sus responsabilidades
4. Flujos principales (happy path + casos de error)
5. Lo que queda fuera del alcance (explícito)

## Paso 4 — Guardar el design doc

Una vez el usuario aprueba el diseño completo:
- Guardar en: `docs/plans/YYYY-MM-DD-<nombre-feature>.md`
- El documento debe incluir todas las decisiones tomadas y su razonamiento.
- Confirmar al usuario: "Design doc guardado en docs/plans/YYYY-MM-DD-<feature>.md"

## Paso 5 — Activar siguiente fase

Después de guardar el design doc, activar hook C-P1:
invocar @el-de-las-gafas para writing-plans.

## Reglas

- NO invocar ninguna skill de implementación (frontend, backend, etc.) desde aquí.
- La ÚNICA skill que se invoca después de brainstorming es writing-plans.
- Si el usuario quiere saltar el brainstorming, respetar su decisión y continuar.
- Las instrucciones explícitas del usuario siempre tienen prioridad sobre esta skill.
