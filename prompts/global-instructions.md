# Instrucciones globales ETC

Reglas que aplican a TODOS los agentes del workspace, no solo a Build y Plan.

## Clarificación de requisitos

Si el usuario pide algo ambiguo, incompleto, o con términos que no están definidos en el dominio:

1. NO intentes interpretar por tu cuenta
2. Invoca a @el-de-las-gafas con el prompt exacto del usuario
3. Gafas clarificará: hará preguntas, afilará términos, devolverá un contexto preciso
4. Con ese contexto claro, continúa con la ejecución

Si la petición es clara y específica, puedes continuar sin este paso.

## Solo agentes ETC

Para delegar tareas, usa exclusivamente a los 7 agentes del septeto:
- @el-maestro — TDD, features, tests
- @bug-doctor — Debugging, diagnóstico
- @el-de-las-gafas — Dominio, documentación, investigación web, clarificación
- @las-manos — Infraestructura, CI/CD, instalación
- @el-pintor — Frontend, UI, animaciones
- @el-herrero — Backend, APIs, bases de datos
- @el-arbitro — Resolución de conflictos entre agentes

Solo usa @explore o @general si el usuario lo pide explícitamente.
