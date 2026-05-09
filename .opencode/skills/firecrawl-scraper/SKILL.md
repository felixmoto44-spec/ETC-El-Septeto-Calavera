---
name: firecrawl-scraper
description: Web scraping con Firecrawl para extraer contenido web en Markdown optimizado para LLMs. 7 modos: search, scrape, map, crawl, agent, interact, download. Úsala para extraer documentación técnica, contenido de webs, y datos estructurados de páginas web.
license: MIT
compatibility: opencode
---

# Firecrawl Scraper

Extrae contenido web en Markdown optimizado para LLMs usando Firecrawl.

## Instalación

```bash
npm install -g firecrawl
# O sin instalar:
npx firecrawl --help
```

Requiere API key de Firecrawl (gratuita, 500K créditos):
- Registrar en https://www.firecrawl.dev
- Setear `export FIRECRAWL_API_KEY=fc-...`

## Modos de uso

### search — Buscar y extraer
```bash
firecrawl search "consulta de búsqueda" --scrape
```
Busca en la web y extrae el contenido de los resultados. Ideal para investigar temas sin URL específica.

### scrape — Extraer URL individual
```bash
firecrawl scrape https://docs.ejemplo.com/pagina
```
Extrae una página web a Markdown limpio. Output en `.firecrawl/output.md`. Soporta SPAs con JS.

Opciones útiles:
- `--formats markdown` — output Markdown (default)
- `--formats html` — output HTML
- `--formats screenshot` — captura de pantalla
- `--onlyMainContent` — solo el contenido principal (sin sidebar, header, footer)

### map — Descubrir URLs del sitio
```bash
firecrawl map https://docs.ejemplo.com
```
Descubre todas las URLs accesibles bajo un dominio. Ideal para documentación:
```bash
firecrawl map https://docs.ejemplo.com/docs/ --search="api,guide,tutorial"
```

Output: lista de URLs que luego puedes procesar con crawl.

### crawl — Extracción masiva
```bash
firecrawl crawl https://docs.ejemplo.com/docs/ --maxPages 100
```
Extrae todas las páginas bajo una ruta. Output en `.firecrawl/` con un archivo por página.

Para documentación técnica:
```bash
# Descubrir primero
firecrawl map https://docs.ejemplo.com/docs/ > /tmp/urls.txt

# Crawlear solo las relevantes
firecrawl crawl https://docs.ejemplo.com/docs/ \
  --maxPages 200 \
  --includePaths "/docs/guide*,/docs/api*" \
  --excludePaths "/docs/archive*,/docs/experimental*"
```

### agent — Extracción AI-powered
```bash
firecrawl agent "Extrae todas las tablas de precios de esta página" --url https://ejemplo.com/pricing
```
Usa AI para extraer información estructurada de sitios complejos. No necesitas selectores CSS.

### interact — Navegación con JS
```bash
firecrawl interact "Haz clic en 'Siguiente página' 3 veces" --url https://ejemplo.com/docs
```
Para sitios que requieren clics, formularios, login, o paginación con JS. Especialmente útil para documentación con navegación dinámica.

### download — Archivo completo
```bash
firecrawl download https://docs.ejemplo.com/docs/ --output ./documentacion/
```
Descarga el sitio completo para consulta offline.

## Estrategias de scraping para El de las Gafas

### Scraping de documentación técnica
1. Buscar `llms.txt` (atajo LLM-friendly): `firecrawl scrape https://docs.ejemplo.com/llms.txt`
2. Si no existe: `firecrawl map https://docs.ejemplo.com/docs/`
3. Crawlear todo: `firecrawl crawl https://docs.ejemplo.com/docs/ --maxPages 200`
4. Si la navegación es compleja: `firecrawl interact "Abre cada sección del menú de navegación"`

### Investigación de bugs en foros
1. `firecrawl search "mensaje de error específico" --scrape`
2. Revisar Stack Overflow, GitHub Issues, foros
3. Comparar resultados y dar nivel de confianza

### Extracción de changelogs y versiones
1. `firecrawl scrape https://github.com/user/repo/releases`
2. `firecrawl crawl https://github.com/user/repo/releases --maxPages 5`

## Output
Los resultados se almacenan en:
- `.firecrawl/output.md` — último scrape
- `.firecrawl/crawl/` — resultados de crawl
- `.firecrawl/map.json` — URLs descubiertas

## Buenas prácticas
- Usa `--onlyMainContent` para documentación (evita ruido de navegación)
- Si una página tarda > 30s, usa `firecrawl interact` en vez de `scrape`
- Para sitios con Cloudflare, considera `browser-act` como alternativa
- Cachea crawls grandes: `firecrawl crawl --deduplicate`
- Respeta `robots.txt` y rate limits (especialmente en documentación de proyectos pequeños)
