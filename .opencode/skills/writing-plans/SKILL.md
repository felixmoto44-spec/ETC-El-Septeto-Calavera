---
name: writing-plans
description: Usar cuando el design doc esté aprobado y haya que convertirlo en un plan de implementación accionable tarea por tarea.
license: MIT
compatibility: opencode
---

# writing-plans

Usar cuando el design doc esté aprobado y haya que convertirlo en un plan
de implementación accionable tarea por tarea.

## Anuncio obligatorio

Al activar esta skill decir:
"Estoy usando la skill writing-plans para crear el plan de implementación."

## Contexto previo requerido

- El design doc debe existir en docs/plans/YYYY-MM-DD-<feature>.md
- Si hay worktree aislado, debe haber sido creado via using-git-worktrees.
- Si el spec cubre múltiples subsistemas independientes y no se descompuso
  en brainstorming, sugerir dividirlo ahora. Cada plan debe producir
  software funcional y testeable por sí solo.

## Paso 1 — Mapear archivos antes de definir tareas

Antes de escribir ninguna tarea, hacer un mapa de:
- Qué archivos se crearán (rutas exactas).
- Qué archivos existentes se modificarán (rutas exactas + líneas aproximadas).
- Qué responsabilidad tiene cada archivo.
- Qué interfaces o tipos se comparten entre archivos.

Esto bloquea las decisiones de descomposición. Cada archivo debe tener
una responsabilidad clara. Diseñar con interfaces bien definidas.

## Paso 2 — Escribir las tareas

Cada tarea debe:
- Durar entre 2 y 5 minutos de implementación.
- Ser completamente autocontenida (un subagente fresco puede ejecutarla
  sin contexto previo del proyecto).
- Incluir rutas exactas de archivos.
- Incluir el código completo que debe escribirse, no pseudocódigo.
- Incluir el comando exacto para verificar que pasa.
- Seguir el ciclo TDD: test primero, implementación después.

Principios obligatorios: DRY · YAGNI · TDD · commits frecuentes

## Formato de cada tarea

### Tarea N: [Nombre del componente]

**Archivos:**
- Crear: `ruta/exacta/al/archivo.py`
- Modificar: `ruta/exacta/al/existente.py` (líneas 45-78)
- Test: `tests/ruta/exacta/test_archivo.py`

- [ ] **Paso 1: Escribir el test que falla**
  ```python
  def test_comportamiento_especifico():
      resultado = funcion(entrada)
      assert resultado == esperado
  ```

- [ ] **Paso 2: Ejecutar el test para verificar que falla**
  Comando: `pytest tests/ruta/test.py::test_nombre -v`
  Esperado: FAIL con "función no definida"

- [ ] **Paso 3: Escribir la implementación mínima**
  ```python
  def funcion(entrada):
      return esperado
  ```

- [ ] **Paso 4: Ejecutar el test para verificar que pasa**
  Comando: `pytest tests/ruta/test.py::test_nombre -v`
  Esperado: PASS

- [ ] **Paso 5: Commit**
  ```bash
  git add tests/ruta/test.py src/ruta/archivo.py
  git commit -m "feat: añadir funcionalidad específica"
  ```

## Cabecera obligatoria del plan

```markdown
# Plan de implementación: [Nombre de la feature]

> **Para agentes:** SKILL REQUERIDA: Usar subagent-driven-development
> para implementar este plan tarea por tarea.
> Los pasos usan sintaxis `- [ ]` para seguimiento.
```

## Paso 3 — Self-check obligatorio post-escritura

Revisar el plan con ojos frescos antes de entregarlo:

1. **Cobertura del spec:** ¿Cada sección del design doc tiene al menos una tarea
   que la implementa? Listar cualquier gap encontrado.
2. **Sin placeholders:** Buscar código incompleto, TODOs sin resolver,
   o nombres de función inconsistentes. Corregirlos inline.
3. **Consistencia de tipos:** ¿Los tipos, firmas de método y nombres de
   propiedad son consistentes entre tareas?

Si se encuentran gaps, añadir las tareas que faltan antes de entregar el plan.

## Guardar el plan

Guardar en: `docs/plans/YYYY-MM-DD-<nombre-feature>.md`

Confirmar al usuario y activar hook S-W1 + C-R1:
el Supervisor invocará @las-manos para worktree y después subagent-driven-development.
