---
name: github-research
description: Buscar en GitHub issues, PRs y discusiones técnicas usando la API de GitHub con curl + jq. Filtra por estado, etiquetas, repo, y fecha. Cachea resultados en .github-cache/ para evitar rate limits. Úsala cuando necesites investigar bugs conocidos, workarounds, o discusiones de desarrollo en repositorios de GitHub.
license: MIT
compatibility: opencode
---

# GitHub Research

Busca y analiza información en GitHub usando la API REST con `curl` y `jq`. Incluye cacheo de resultados, manejo de paginación, y ejemplos concretos de queries.

## ✨ Funciona sin API key (gratis)

La API pública de GitHub permite **60 requests por hora sin autenticación**. Suficiente para la mayoría de investigaciones puntuales. Con token aumentas a 5000 req/hora.

## Configuración

### GitHub Token (opcional — aumenta rate limit)
```bash
# Opcional: para aumentar rate limit de 60 a 5000 requests/hora
export GITHUB_TOKEN=ghp_xxxxxxxxxxxx

# Verificar que funciona
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/rate_limit | jq '.rate'
```

### Cache de resultados
Crea el directorio de cache:
```bash
mkdir -p .github-cache
```

## Ejemplos sin token (recomendado para empezar)

Si no tienes `GITHUB_TOKEN` configurado, estos comandos funcionan igual:

### Buscar issues públicos
```bash
curl -s "https://api.github.com/search/issues?q=repo:user/repo+bug+state:closed&per_page=5" | \
  jq '.items[] | {number, title, state, labels: [.labels[].name]}'
```

### Obtener info de un repo
```bash
curl -s "https://api.github.com/repos/user/repo" | \
  jq '{name, description, stars: .stargazers_count, forks, open_issues}'
```

### Buscar en todos los repos públicos de un usuario
```bash
curl -s "https://api.github.com/search/issues?q=user:username+bug&per_page=5" | \
  jq '.items[] | {number, title, state}'
```

### Verificar rate limit restante
```bash
curl -s https://api.github.com/rate_limit | jq '{core: .rate.remaining, search: .resources.search.remaining}'
```

> ⚠️ **Sin token**: 60 req/hora. Si ves `403` o `401`, espera o configura un token.
> Con token: 5000 req/hora. Configura `export GITHUB_TOKEN=ghp_...` en tu shell.

## Cuándo usarla

- Un error tiene un stack trace que apunta a una dependencia específica
- Necesitas saber si un bug ya fue reportado y solucionado
- Quieres entender discusiones de diseño en un repositorio
- Buscas workarounds documentados en issues cerrados
- Necesitas verificar si un PR ya fue mergeado
- Quieres saber cuántos issues hay de un tipo específico

## Comandos básicos

### Buscar issues cerrados sobre un error específico
```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+error+timeout+state:closed&per_page=10" | \
  jq '.items[] | {number, title, state, labels: [.labels[].name], created_at, comments}'
```

### Obtener un issue concreto con su body completo
```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/user/repo/issues/1234" | \
  jq '{number, title, state, body, comments_url}'
```

### Buscar PRs mergeados sobre un tema
```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+label:bug+is:merged&per_page=5" | \
  jq '.items[] | {number, title, merged_at: .pull_request.merged_at}'
```

### Leer comentarios de un issue
```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/user/repo/issues/1234/comments?per_page=5" | \
  jq '.[] | {user: .user.login, body: .body[:200]}'
```

## Cache de resultados para evitar rate limits

### Script de cache (con y sin token)
```bash
# ~/bin/gh-cached.sh
#!/bin/bash
CACHE_DIR=".github-cache"
CACHE_KEY=$(echo "$1" | md5sum | cut -d' ' -f1)
CACHE_FILE="$CACHE_DIR/$CACHE_KEY.json"
HEADER=""
[ -n "$GITHUB_TOKEN" ] && HEADER="-H \"Authorization: token $GITHUB_TOKEN\""

if [ -f "$CACHE_FILE" ] && [ $(($(date +%s) - $(stat -c %Y "$CACHE_FILE"))) -lt 3600 ]; then
  cat "$CACHE_FILE"
else
  eval curl -s $HEADER "$1" | tee "$CACHE_FILE"
fi
```

Uso (funciona con o sin GITHUB_TOKEN):
```bash
gh-cached.sh "https://api.github.com/search/issues?q=repo:user/repo+bug+state:closed"
```

### Cache manual por query
```bash
# Guardar resultado en cache
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+error+state:closed&per_page=50" \
  > .github-cache/issues-error-closed.json

# Reusar sin llamar a la API
cat .github-cache/issues-error-closed.json | jq '.items[] | {number, title}'
```

## Patrones de búsqueda por label, estado, repo y fecha

### Por label
```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+label:bug+label:critical+state:open"
```

### Por rango de fechas
```bash
# Issues creados en los últimos 7 días
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+created:>$(date -d '7 days ago' +%Y-%m-%d)"

# Issues actualizados en el último mes
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+updated:>$(date -d '1 month ago' +%Y-%m-%d)"
```

### Combinaciones útiles
```bash
# Bugs cerrados con solución (commentario del autor)
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+label:bug+state:closed+comments:>0&sort=updated&order=desc"

# PRs de una release específica
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+label:release-v2+is:pr+is:merged"

# Issues de rendimiento
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+label:performance+state:closed"
```

### Buscar en todos los repos de una organización
```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=org:mi-org+error+database+state:closed&per_page=20"
```

## Paginación con Link headers

La API de GitHub paginación resultados. El header `Link` contiene las URLs de las páginas siguiente/última.

### Script para paginar
```bash
# Extraer URL de la página siguiente del Link header
NEXT_URL=$(curl -sI -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+bug&per_page=100" | \
  grep -oP '<([^>]+)>; rel="next"' | grep -oP 'https://[^>]+')

# Iterar por todas las páginas
PAGE=1
URL="https://api.github.com/search/issues?q=repo:user/repo+bug&per_page=100&page=$PAGE"
while [ -n "$URL" ]; do
  RESPONSE=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "$URL")
  echo "$RESPONSE" | jq '.items[] | {number, title}'
  # Obtener URL de la página siguiente
  URL=$(curl -sI -H "Authorization: token $GITHUB_TOKEN" "$URL" | \
    grep -oP '<([^>]+)>; rel="next"' | grep -oP 'https://[^>]+')
  PAGE=$((PAGE + 1))
done
```

### Función auxiliar para paginación
```bash
# gh-paginate.sh: Itera todas las páginas de una búsqueda
paginate_gh() {
  local URL="$1"
  while [ -n "$URL" ]; do
    RESPONSE=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "$URL")
    echo "$RESPONSE" | jq '.items[] | {number, title, state}'
    URL=$(echo "$RESPONSE" | jq -r '.incomplete_results')
    # Extraer next del Link header
    URL=$(curl -sI -H "Authorization: token $GITHUB_TOKEN" "$URL" | \
      grep -oP '<([^>]+)>; rel="next"' | sed 's/<\([^>]*\)>.*/\1/')
  done
}
```

### Usar `per_page` máximo para reducir páginas
```bash
# Máximo 100 por página (default 30)
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+bug&per_page=100&page=1"
```

## Parseo avanzado con jq

### Extraer info estructurada de issues
```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+error+state:closed" | \
  jq '[.items[] | {
    number,
    title,
    state,
    labels: [.labels[].name],
    comments,
    created_at,
    updated_at,
    author: .user.login,
    url: .html_url
  }]'
```

### Contar ocurrencias por label
```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+state:closed" | \
  jq '[.items[] | .labels[].name] | group_by(.) | map({label: .[0], count: length}) | sort_by(-.count)'
```

### Filtrar issues con milestone
```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+milestone:v2.0+state:closed" | \
  jq '[.items[] | {number, title, milestone: .milestone.title} ]'
```

### Combinar datos de varias queries
```bash
# Total de issues abiertos vs cerrados
ABIERTOS=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+state:open" | jq '.total_count')
CERRADOS=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:user/repo+state:closed" | jq '.total_count')
echo "Abiertos: $ABIERTOS | Cerrados: $CERRADOS"
```

## Flujo de investigación completo

1. **Buscar bugs conocidos:**
   ```bash
   SEARCH_QUERY="repo:user/repo+error+timeout+state:closed"
   curl -s -H "Authorization: token $GITHUB_TOKEN" \
     "https://api.github.com/search/issues?q=$SEARCH_QUERY&per_page=10" \
     > .github-cache/bugs-timeout.json
   cat .github-cache/bugs-timeout.json | jq '[.items[] | {number, title, state}]'
   ```

2. **Leer issue relevante:**
   ```bash
   ISSUE_NUMBER=$(cat .github-cache/bugs-timeout.json | jq -r '.items[0].number')
   curl -s -H "Authorization: token $GITHUB_TOKEN" \
     "https://api.github.com/repos/user/repo/issues/$ISSUE_NUMBER" | \
     jq '{number, title, body}'
   ```

3. **Ver comentarios con solución:**
   ```bash
   curl -s -H "Authorization: token $GITHUB_TOKEN" \
     "https://api.github.com/repos/user/repo/issues/$ISSUE_NUMBER/comments" | \
     jq '.[] | {user: .user.login, body: .body[:500]}'
   ```

## Criterios de relevancia

- Issues cerrados con label `bug` o `solution` son los más fiables
- PRs mergeados con tests son evidencia de fix confirmado
- Issues abiertos sin actividad > 6 meses = probablemente abandonados
- Comentarios del mantenedor tienen más peso que comentarios de usuarios
- Issues con `+1` o reacciones en el primer comentario indican impacto amplio

## Output esperado

- Resumen del issue/PR: título, estado, fecha, labels
- Solución propuesta o workaround
- Confianza: alta (fix mergeado), media (workaround sin merge), baja (discusión abierta)
- Citas textuales del código de ejemplo o configuración

## Buenas prácticas

- ✅ **Sin token funciona**: empieza sin token (60 req/hora). Solo configura token si necesitas más
- 🔄 **Cachea resultados** en `.github-cache/` para no repetir queries idénticas y ahorrar rate limit
- 📊 **Monitorea tu rate limit**: `curl -s https://api.github.com/rate_limit | jq '.rate.remaining'`
- 📏 Usa `per_page=100` para minimizar páginas en resultados grandes
- 🎯 Filtra por `state:closed` para encontrar soluciones, no reportes
- ✅ Prefiere `is:merged` sobre `state:closed` para PRs (evita PRs cerrados sin merge)
- 📅 Las fechas en GitHub API son ISO 8601: `2024-01-15T10:30:00Z`
- ⏳ Si reaches rate limit, espera 1 hora o configura `GITHUB_TOKEN`
- 🐌 Respeta rate limits: 1 request/segundo como cortesía (especialmente sin token)
