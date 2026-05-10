---
name: log-analysis
description: Analizar logs de aplicaciones, servidores, procesos y sistemas. Extraer patrones de error, diagnosticar causas raíz, y recomendar acciones correctivas. Compatible con journalctl, syslog, nginx, docker, y logs de aplicación.
license: MIT
compatibility: opencode
---

# Log Analysis

Analiza logs de sistemas, aplicaciones y servicios para diagnosticar problemas.

## Fuentes de logs

### System logs (Linux)
```bash
# Logs del sistema (journald)
journalctl -xe                    # Últimos errores del sistema
journalctl -u nginx --no-pager   # Logs de un servicio específico
journalctl --since "1 hour ago"  # Logs de la última hora
journalctl -p err                # Solo errores

# Logs tradicionales
tail -f /var/log/syslog
tail -f /var/log/auth.log        # Intentos de login
```

### Web server logs
```bash
# Nginx
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log
# Buscar errores 5xx
grep 'HTTP/1.[01]" 5[0-9][0-9]' /var/log/nginx/access.log | tail -20

# Apache
tail -f /var/log/apache2/access.log
tail -f /var/log/apache2/error.log
```

### Docker logs
```bash
docker logs <container>          # Logs de un contenedor
docker logs -f <container>       # Seguir logs en tiempo real
docker logs --tail 100 <cont>    # Últimas 100 líneas
docker-compose logs -f           # Logs de todo el stack
```

### Aplicación
```bash
# Node.js/PM2
pm2 logs                    # Logs en tiempo real
pm2 logs --lines 100        # Últimas 100 líneas

# Python
tail -f /var/log/app.log

# Cualquier app con systemd
journalctl -u mi-app -f
```

## Patrones de error comunes

| Patrón | Posible causa | Acción |
|--------|--------------|--------|
| `Out of memory` | Falta RAM en servidor | Verificar con `free -h`, añadir swap |
| `Connection refused` | Puerto no abierto o servicio caído | `systemctl status servicio`, `ss -tlnp` |
| `No space left on device` | Disco lleno | `df -h`, `du -sh /tmp/*`, limpiar |
| `Permission denied` | Permisos incorrectos | `ls -la`, `chmod`/`chown`, verificar usuario |
| `ETIMEDOUT` | Timeout de red | Verificar conectividad, firewalls, DNS |
| `ECONNREFUSED` | Conexión rechazada | Servicio no corriendo o puerto bloqueado |
| `Segmentation fault` | Bug en programa o falta de memoria | `dmesg`, `coredumpctl`, reiniciar |
| `Cannot find module` | Dependencia faltante | Reinstalar dependencias, verificar package.json |
| `Port 80 already in use` | Puerto ocupado | `ss -tlnp \| grep 80`, cambiar puerto o matar proceso |

## Estrategia de análisis

1. Identificar el tipo de log (system, web, docker, app)
2. Buscar errores con `grep -i "error\|fail\|exception\|critical"` o `journalctl -p err`
3. Analizar el contexto alrededor del error (5 líneas antes y después)
4. Identificar el patrón del error
5. Determinar si es error de configuración, bug, o recurso
6. Si no está claro tras 2 intentos → llamar al agente de diagnóstico correspondiente
