---
name: using-git-worktrees
description: Usar cuando el design doc esté aprobado y haya que crear un workspace aislado antes de empezar a implementar.
license: MIT
compatibility: opencode
---

# using-git-worktrees

Usar cuando el design doc esté aprobado y haya que crear un workspace
aislado antes de empezar a implementar.

## Anuncio obligatorio

Al activar esta skill decir:
"Estoy usando la skill using-git-worktrees para preparar un workspace aislado."

## Paso 0 — Verificar si ya estamos en un worktree aislado

Antes de crear nada, comprobar:

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
BRANCH=$(git branch --show-current)
```

Guardia de submódulo — GIT_DIR != GIT_COMMON también es cierto dentro
de submódulos. Verificar antes de concluir que ya estamos en un worktree:

```bash
# Si devuelve una ruta, estamos en un submódulo, no en un worktree
git rev-parse --show-superproject-working-tree 2>/dev/null
```

- Si GIT_DIR != GIT_COMMON y NO es submódulo: ya estamos en un worktree.
  Saltar directamente al Paso 3. NO crear otro worktree.
- Si GIT_DIR == GIT_COMMON o es submódulo: checkout normal. Continuar Paso 1.

## Paso 1 — Pedir consentimiento si no hay preferencia declarada

Si no hay preferencia declarada en las instrucciones del proyecto, preguntar:
"¿Quieres que configure un worktree aislado? Protege tu rama actual de cambios."

Respetar cualquier preferencia declarada sin preguntar de nuevo.
Si el usuario rechaza, trabajar en el directorio actual y saltar al Paso 3.

## Paso 2 — Crear el worktree

Determinar la ubicación en este orden:
1. Preferencia declarada en instrucciones del proyecto.
2. `.worktrees/` si ya existe y está en .gitignore.
3. `worktrees/` si ya existe y está en .gitignore.
4. Preguntar:
   ```
   No se encontró directorio de worktrees. ¿Dónde los creo?
   1. .worktrees/ (local al proyecto, oculto)
   2. ~/.config/opencode/worktrees/<nombre-proyecto>/ (global)
   ```

OBLIGATORIO antes de crear: verificar que el directorio está en .gitignore:

```bash
git check-ignore -q .worktrees 2>/dev/null || git check-ignore -q worktrees 2>/dev/null
```

Si NO está ignorado: añadir a .gitignore, commitear el cambio, luego continuar.

Crear el worktree:

```bash
BRANCH_NAME="feature/<nombre-del-diseño>"
git worktree add ".worktrees/$BRANCH_NAME" -b "$BRANCH_NAME"
cd ".worktrees/$BRANCH_NAME"
```

## Paso 3 — Setup del proyecto

```bash
# Node.js
if [ -f package.json ]; then npm install; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f pyproject.toml ]; then poetry install; fi

# Rust
if [ -f Cargo.toml ]; then cargo build; fi

# Go
if [ -f go.mod ]; then go mod download; fi
```

## Paso 4 — Verificar baseline de tests

Ejecutar la suite de tests completa antes de tocar nada.

Si los tests fallan:
- Reportar los fallos al usuario.
- Preguntar si proceder o investigar primero.
- NO continuar con implementación hasta resolverlo.

Si los tests pasan, reportar:
```
Worktree listo en: .worktrees/<branch-name>
Tests pasando: <N> tests, 0 fallos
Listo para implementar: <nombre-feature>
```

## Paso 5 — Confirmar y activar siguiente fase

Confirmar al usuario que el workspace está listo.
El Supervisor puede ahora iniciar subagent-driven-development.
