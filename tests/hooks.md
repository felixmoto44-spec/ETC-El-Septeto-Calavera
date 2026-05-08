# ETC — Tests de Hooks

Escenarios de validación para los 43 hooks de colaboración (C1–C43).

Cómo usar: ejecuta manualmente cada escenario y verifica que el agente produce el output esperado. Un hook "pasa" cuando el agente invoca al colega correcto con el contexto correcto.

---

## Hooks C1–C14: El Trío Original

### C1 — Maestro → Bug Doctor

**Disparador:** Bug complejo reportado durante un ciclo TDD

**Input de prueba:**
```
@el-maestro Estoy en la fase GREEN. El test pasa pero en producción el endpoint
/api/orders devuelve 500 intermitentemente, solo cuando hay más de 3 requests
simultáneos. No sé reproducirlo localmente.
```

**Output esperado:**
- El Maestro reconoce que el bug está fuera de su ciclo TDD normal
- Invoca explícitamente a Bug Doctor: "@bug-doctor necesito tu diagnóstico..."
- Proporciona el contexto del bug (endpoint, condición de concurrencia)
- NO intenta arreglarlo directamente

**Criterio de fallo:** El Maestro intenta debuggear sin derivar a Bug Doctor.

---

### C2 — Maestro → Gafas (términos no documentados)

**Disparador:** Feature que toca términos del dominio no documentados en CONTEXT.md

**Input de prueba:**
```
@el-maestro Implementa la feature de "aprobación delegada" para órdenes de compra.
El manager puede delegar la aprobación a un subordinado con límite de importe.
```

**Output esperado:**
- El Maestro identifica que los términos son de dominio
- Deriva a Gafas antes de entrar en el ciclo TDD
- Lista explícitamente los términos a clarificar
- NO escribe código hasta tener clarificación

**Criterio de fallo:** El Maestro empieza a escribir tests con términos asumidos.

---

### C4 — Maestro → Gafas (risk score ≥ 60)

**Disparador:** PLAN produce un score BLOCK en la fase INIT

**Input de prueba:**
```
@el-maestro INIT: Refactorizar el sistema de autenticación para migrar de
JWT stateless a sessions con Redis. Afecta a todos los endpoints protegidos.
Necesito que no haya downtime y que los usuarios no tengan que volver a logarse.
```

**Output esperado:**
- El Maestro ejecuta INIT, produce PLAN con score ≥ 60 (BLOCK)
- Invoca a Gafas para segunda revisión
- Documenta por qué el score es alto
- NO procede al ciclo RED sin aprobación de Gafas

**Criterio de fallo:** El Maestro continúa con score BLOCK sin invocar a Gafas.

---

### C7 — Bug Doctor → Gafas (hipótesis toca dominio)

**Disparador:** Bug Doctor formula hipótesis que involucra reglas de negocio

**Input de prueba:**
```
@bug-doctor El bug: los pedidos de tipo "urgente" no reciben el descuento
corporativo del 15% aunque el cliente tiene el flag is_corporate=true.
Reproduzco el bug consistentemente creando un pedido con priority="urgent"
para customer_id=42.
```

**Output esperado:**
- Bug Doctor formula hipótesis sobre la regla de negocio
- Identifica que "urgente" y "descuento corporativo" son conceptos de dominio
- Deriva a Gafas antes de instrumentar una hipótesis de dominio
- Espera confirmación de Gafas antes de declarar la hipótesis como válida

**Criterio de fallo:** Bug Doctor asume la regla de negocio sin consultar a Gafas.

---

### C9 — Bug Doctor → Maestro (fix listo)

**Disparador:** Bug Doctor ha identificado causa raíz y tiene fix listo

**Input de prueba (continuación de C7):**
```
@bug-doctor [Continuación] Gafas confirmó: la regla dice que descuentos
corporativos NO aplican a pedidos urgentes. El bug era que el código
SÍ aplicaba el descuento. El fix: añadir condición en applyDiscount().
Necesito que esto quede cubierto con tests.
```

**Output esperado:**
- Bug Doctor documenta la causa raíz
- Invoca al Maestro con el fix propuesto y el test de regresión
- NO implementa el fix directamente

**Criterio de fallo:** Bug Doctor implementa el fix sin derivar al Maestro.

---

### C11 — Gafas → Bug Doctor (código ≠ docs)

**Disparador:** Gafas detecta contradicción grave entre código y documentación

**Input de prueba:**
```
@el-de-las-gafas Revisando CONTEXT.md veo que "Customer" en el glosario se define
como "empresa con contrato activo", pero en el código el modelo Customer incluye
clientes individuales y prospects. La diferencia es importante porque las reglas
de precios son distintas.
```

**Output esperado:**
- Gafas documenta la contradicción encontrada
- Deriva a Bug Doctor: "esto parece un bug de lógica de negocio..."
- Especifica el módulo afectado y el impacto potencial
- Actualiza CONTEXT.md con "contradicción pendiente de resolver"

**Criterio de fallo:** Gafas asume cuál versión es correcta sin consultar a Bug Doctor.

---

### C12 — Gafas → Maestro (regla de dominio sin tests)

**Disparador:** Gafas identifica regla de dominio crítica sin cobertura

**Input de prueba:**
```
@el-de-las-gafas Encuentro que la regla "un pedido no puede aprobarse a sí mismo
por quien lo creó" no tiene ningún test que la valide. Es una regla de compliance.
```

**Output esperado:**
- Gafas documenta la regla en CONTEXT.md con flag [SIN_TEST]
- Invoca al Maestro para que escriba el test y los blinde con TDD
- NO escribe el test ella misma

**Criterio de fallo:** Gafas escribe el test directamente.

---

## Hooks C15–C23: El Cuarteto

### C15 — Maestro → Las Manos (pipeline CI/CD)

**Disparador:** Feature lista para deploy, no existe pipeline

**Input de prueba:**
```
@el-maestro La feature de autenticación OAuth está en GREEN, todos los tests
pasan. Necesitamos deployarla a staging. No tenemos pipeline de CI/CD configurado
para este proyecto.
```

**Output esperado:**
- El Maestro verifica que el entorno de testing está completo
- Invoca a Las Manos: "@las-manos necesito pipeline de CI/CD..."
- Proporciona el contexto: stack tech, destino, tests a ejecutar en CI

**Criterio de fallo:** El Maestro intenta configurar CI/CD sin derivar a Las Manos.

---

### C18 — Bug Doctor → Las Manos (bug de seguridad)

**Disparador:** Bug Doctor descubre secreto expuesto o vulnerabilidad

**Input de prueba:**
```
@bug-doctor Mientras investigaba el bug, encontré que el stack trace
completo se loguea en la respuesta de error en producción. El trace incluye
connection strings de la base de datos y API keys en variables de entorno.
```

**Output esperado:**
- Bug Doctor escala a Las Manos INMEDIATAMENTE: "incidente de seguridad SEV-1..."
- Proporciona el detalle exacto de lo expuesto
- Bug Doctor NO continúa con su diagnóstico original hasta que el incidente esté mitigado

**Criterio de fallo:** Bug Doctor documenta el hallazgo pero no escala.

---

## Hooks C24–C29: El Pintor

### C24 — Pintor → Maestro (componente UI listo)

**Disparador:** El Pintor ha completado el diseño de un componente

**Input de prueba:**
```
@el-pintor Diseña el componente OrderStatusBadge: muestra el estado de un pedido
(pending/approved/rejected/urgent) con el color y texto correspondiente.
Debe ser accesible WCAG 2.1 AA y funcionar en modo dark.
```

**Output esperado:**
- El Pintor diseña el componente con especificaciones visuales completas
- Define el contrato de props
- Invoca al Maestro: "componente diseñado, aquí el contrato visual..."
- Proporciona test cases de accesibilidad

**Criterio de fallo:** El Pintor implementa el componente sin pasar por el Maestro.

---

### C28 — Pintor → Herrero (necesita endpoint)

**Disparador:** El Pintor diseña UI que requiere un endpoint inexistente

**Input de prueba:**
```
@el-pintor Estoy diseñando el dashboard de pedidos. Necesito mostrar:
pedidos del último mes agrupados por estado, con totales de importe.
¿Existe este endpoint o necesito pedirlo?
```

**Output esperado:**
- El Pintor especifica exactamente qué datos necesita la UI
- Deriva a El Herrero: "necesito un endpoint que devuelva..."
- Define el contrato mínimo: ruta, método, estructura del response

**Criterio de fallo:** El Pintor implementa un mock permanente sin consultar a El Herrero.

---

## Hooks C30–C35: El Herrero

### C30 — Herrero → Maestro (endpoint modelado)

**Disparador:** El Herrero ha modelado un endpoint listo para TDD

**Input de prueba:**
```
@el-herrero [Respuesta a Pintor] El endpoint para el dashboard:
GET /api/orders/summary?from=2026-04-01&to=2026-05-01
Ya tengo el schema SQL y el plan de query con índices. Listo para TDD.
```

**Output esperado:**
- El Herrero documenta el contrato completo del endpoint
- Invoca al Maestro: "endpoint diseñado, aquí el contrato..."
- Proporciona: ruta, método, parámetros, response schema, errores
- Invoca al Pintor: "aquí el contrato final de API..."

**Criterio de fallo:** El Herrero implementa el endpoint sin pasar por el ciclo TDD.

---

### C33 — Herrero → Bug Doctor (race condition)

**Disparador:** El Herrero detecta una race condition o deadlock

**Input de prueba:**
```
@el-herrero Revisando los logs de producción veo deadlocks en la tabla orders
cuando dos usuarios aprueban pedidos simultáneamente. Ocurre ~3 veces por hora.
```

**Output esperado:**
- El Herrero identifica el problema como bug de concurrencia
- Deriva a Bug Doctor con: query problemática, frecuencia, logs exactos
- NO intenta "arreglarlo" añadiendo NOWAIT sin diagnóstico completo

**Criterio de fallo:** El Herrero añade FOR UPDATE SKIP LOCKED sin diagnóstico formal.

---

## Hooks C36–C43: Originales → Pintor y Herrero

### C37 — Maestro → Herrero (feature con scope backend)

**Disparador:** El Maestro detecta que la feature necesita diseño de API/DB

**Input de prueba:**
```
@el-maestro INIT: Implementar el sistema de notificaciones. Los usuarios deben
recibir emails cuando su pedido cambia de estado. Las notificaciones deben
ser configurables por tipo y canal (email, SMS).
```

**Output esperado:**
- El Maestro ejecuta INIT, detecta scope de backend
- Invoca a El Herrero: "necesita diseño de backend..."
- No entra en ciclo RED hasta tener el diseño

**Criterio de fallo:** El Maestro empieza a escribir tests para un schema no diseñado.

---

### C43 — Las Manos → Herrero (infraestructura provisionada)

**Disparador:** Las Manos ha provisionado infraestructura que El Herrero necesita

**Input de prueba:**
```
@las-manos El Herrero necesita Redis para el sistema de caché de sesiones.
Provisiona una instancia de Redis en Railway y configura las variables de entorno.
```

**Output esperado:**
- Las Manos provisiona Redis
- Configura variables: REDIS_URL, REDIS_TOKEN
- Notifica a El Herrero con las variables exactas y snippet de conexión

**Criterio de fallo:** Las Manos provisiona sin notificar a El Herrero.

---

## Ciclos compuestos

### Ciclo "Full-stack feature" (C37→C34→C24→C30)

**Paso 1:** `@el-maestro INIT: Exportar pedidos a CSV desde el dashboard`
- ¿El Maestro invocó a El Herrero? ✓/✗

**Paso 2:** El Herrero diseña endpoint GET /api/orders/export
- ¿El Herrero devolvió contrato de API? ✓/✗
- ¿El Herrero notificó a El Pintor con el contrato? ✓/✗

**Paso 3:** El Pintor diseña botón de export + estado "generando"
- ¿El Pintor invocó al Maestro con el contrato visual? ✓/✗ (C24)

**Paso 4:** El Maestro recibe ambos contratos (UI + API)
- ¿Entró en ciclo TDD para frontend y backend por separado? ✓/✗ (C30)

---

### Ciclo "Bug revela deuda de dominio" (C7→C11→C10→C14)

**Paso 1:** Bug Doctor recibe bug sobre descuentos incorrectos
- ¿Consultó a Gafas sobre reglas de negocio? ✓/✗ (C7)

**Paso 2:** Gafas encuentra contradicción en CONTEXT.md
- ¿Derivó a Bug Doctor? ✓/✗ (C11)

**Paso 3:** Fix implementado por el Maestro
- ¿Bug Doctor pidió a Gafas actualizar CONTEXT.md? ✓/✗ (C10)

**Paso 4:** Gafas revisa otros módulos
- ¿Encontró patrón de ambigüedad y notificó a Bug Doctor? ✓/✗ (C14)

---

## Plantilla de reporte

```markdown
## Resultado: Hook C[N] — [Agente origen] → [Agente destino]

**Fecha:** YYYY-MM-DD
**Versión:** vX.Y.Z
**Modelo:** claude-sonnet-4-5

### Input usado
[Pega el prompt exacto]

### Resultado
- [ ] PASS — El agente invocó al colega correcto con el contexto correcto
- [ ] FAIL — [descripción del fallo]
- [ ] PARCIAL — Invocó correctamente pero faltó contexto

### Notas
[Observaciones, edge cases, sugerencias]
```
