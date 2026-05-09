---
name: finishing-a-development-branch
description: Usar cuando todas las tareas del plan estén completadas y haya que cerrar la rama de desarrollo de forma limpia.
license: MIT
compatibility: opencode
---

# finishing-a-development-branch

Usar cuando todas las tareas del plan estén completadas y haya que cerrar
la rama de desarrollo de forma limpia.

## Anuncio obligatorio

Al activar esta skill decir:
"Estoy usando la skill finishing-a-development-branch para cerrar esta rama."

## Paso 1 — Verificar tests

Ejecutar la suite completa de tests.

Si los tests fallan:
```
Tests fallando: N fallos. Deben corregirse antes de cerrar.
[Mostrar los fallos]
No se puede proceder con merge/PR hasta que los tests pasen.
```
PARAR. No continuar al Paso 2.

Si los tests pasan: continuar al Paso 2.

## Paso 2 — Identificar rama base

```bash
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
```

Si no se puede determinar automáticamente, preguntar al usuario.

## Paso 3 — Presentar opciones al usuario

```
Implementación completa. ¿Qué quieres hacer?

1. Hacer merge a <rama-base> localmente
2. Push y crear Pull Request
3. Mantener la rama tal cual (lo gestiono yo después)
4. Descartar este trabajo

¿Qué opción prefieres?
```

No añadir explicaciones — mantener las opciones concisas.

## Paso 4 — Ejecutar la opción elegida

### Opción 1: Merge local

```bash
git checkout <rama-base>
git pull
git merge <rama-feature>
# Verificar tests en el resultado del merge
# Si los tests pasan:
git branch -d <rama-feature>
```

### Opción 2: Pull Request

```bash
git push origin <rama-feature>
# Crear PR via CLI del proveedor
# Incluir en el PR: enlace al design doc, resumen de cambios
```

### Opción 3: Mantener rama

No hacer nada. Confirmar la ruta de la rama al usuario para referencia futura.

### Opción 4: Descartar

```bash
git checkout <rama-base>
git branch -D <rama-feature>
```

## Paso 5 — Limpiar el worktree

Solo limpiar worktrees dentro de `.worktrees/` (creados por esta skill).
No tocar worktrees en otras ubicaciones.

```bash
git worktree remove ".worktrees/<rama-feature>"
```

## Paso 6 — Confirmar al usuario

```
Rama <nombre> cerrada correctamente.
Opción elegida: [merge local / PR creado / mantenida / descartada]
Worktree limpiado: .worktrees/<rama-feature>
```

## Caso especial: Detached HEAD

Si la rama está en estado detached HEAD, el menú se reduce a dos opciones:
1. Crear una rama nueva desde aquí y hacer PR.
2. Descartar el trabajo.
