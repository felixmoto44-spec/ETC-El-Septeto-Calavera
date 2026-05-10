# ETC Security

## Supply Chain
- Skills origen: morodomi/tdd-skills, mattpocock/skills, obra/superpowers
- Verificar integridad: comparar SHA de releases
- No instalar skills de terceros sin auditoría previa (skill-security-auditor)

## Configuración
- opencode.json con allowlist explícita + *: deny
- No compartir .env ni secrets en el repo
- git-guardrails para prevenir leaks
