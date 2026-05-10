---
name: web-scraper
description: Extraer contenido web a Markdown usando herramientas nativas del sistema (curl, lynx, html2text). Gratis, sin API keys, sin configuración. Úsala para investigar documentación técnica, páginas web, y obtener información de internet.
license: MIT
compatibility: opencode
---

# Web Scraper — Investigación web gratuita

Extrae contenido de páginas web usando herramientas nativas del sistema.
Sin API keys, sin costes, sin configuración.

## Métodos de extracción (gratis, sin config)

### 1. lynx -dump (recomendado)
```bash
lynx -dump -nolist https://ejemplo.com/pagina
```
Convierte cualquier página a texto plano, limpiando HTML, CSS, JS.
`-nolist` omite la lista de enlaces al final.
Ideal para: documentación técnica, artículos, blogs, páginas estáticas.

### 2. curl + html2text
```bash
curl -sL https://ejemplo.com | html2text
```
`curl` descarga el HTML, `html2text` lo convierte a Markdown.
Ideal para: páginas con formato simple, documentación.

### 3. curl + grep/sed (extracción selectiva)
```bash
curl -sL https://docs.ejemplo.com | grep -oP '(?<=<title>).*?(?=</title>)'
```
Extraer solo partes específicas de una página.
Ideal para: obtener títulos, versiones, fechas, metadatos.

### 4. GitHub API (curl + jq) — sin token
```bash
curl -s https://api.github.com/repos/user/repo | jq '.stargazers_count, .description'
```
La API pública de GitHub permite 60 requests/hora sin token.
Ideal para: información de repos, issues, releases.

## Estrategias según el tipo de contenido

### Documentación técnica
```bash
# 1. Descubrir estructura
lynx -dump -nolist https://docs.ejemplo.com/docs/ | grep -E '^  (http|/)' | head -30

# 2. Extraer página específica
lynx -dump -nolist https://docs.ejemplo.com/docs/api/endpoint

# 3. Buscar en la documentación (grep local)
curl -sL https://docs.ejemplo.com/docs/ | html2text | grep -i "keyword"
```

### Stack Overflow
```bash
# Buscar error específico
lynx -dump -nolist "https://stackoverflow.com/search?q=error+message+python" | head -100
```

### GitHub Issues (público)
```bash
# Obtener issues recientes sin token
curl -s "https://api.github.com/search/issues?q=repo:user/repo+bug&per_page=5" | jq '.items[] | {title, state, number}'
```

## Instalación de herramientas

```bash
# Las herramientas necesarias (solo una vez)
sudo apt install -y lynx html2text  # Linux
brew install lynx html2text          # macOS
```

## Opcional: Firecrawl (con API key)

Si el usuario configuró firecrawl, se puede usar como alternativa premium:
```bash
firecrawl scrape https://ejemplo.com
firecrawl search "consulta" --scrape
```
Firecrawl requiere: `npm install -g firecrawl` + `FIRECRAWL_API_KEY`.

## Buenas prácticas
- Usa `lynx -dump` como primera opción (más fiable)
- Si la página tiene JS pesado, prueba con `curl` primero
- Para APIs REST, usa `curl + jq`
- Cachea resultados grandes en `/tmp/`
- Respeta `robots.txt` y rate limits (1 req/segundo como cortesía)
