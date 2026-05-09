---
name: test-driven-development
description: Usar cuando se vaya a implementar cualquier feature o bugfix, ANTES de escribir código de implementación.
license: MIT
compatibility: opencode
---

# test-driven-development

Usar cuando se vaya a implementar cualquier feature o bugfix,
ANTES de escribir código de implementación.

## El ciclo obligatorio: RED → GREEN → REFACTOR

### RED — Escribir el test que falla

1. Escribir el test que describe el comportamiento esperado.
2. Ejecutar el test.
3. Verificar que FALLA. Si pasa inmediatamente: el test está mal escrito.
   Revisar y corregir antes de continuar.

```bash
pytest tests/ruta/test_feature.py::test_comportamiento -v
# Resultado esperado: FAILED
```

### GREEN — Mínima implementación para pasar

4. Escribir el mínimo código que hace pasar el test.
   Solo el código necesario. Sin over-engineering.
5. Ejecutar el test y verificar que PASA.

```bash
pytest tests/ruta/test_feature.py::test_comportamiento -v
# Resultado esperado: PASSED
```

### REFACTOR — Limpiar sin romper

7. Refactorizar si hay duplicación o complejidad innecesaria.
8. Ejecutar todos los tests para verificar que ninguno rompió.
9. Commit.

```bash
git add tests/ruta/test_feature.py src/ruta/feature.py
git commit -m "feat: descripción específica del comportamiento añadido"
```

## Reglas sin excepción

**Código escrito antes del test: eliminarlo y empezar de nuevo.**
No hay excepciones. No hay casos especiales.

- Los bugs se corrigen con TDD: primero el test que reproduce el bug, luego el fix.
- "Ya lo probé manualmente" no es TDD. No cuenta.
- "Los tests después logran lo mismo" no es TDD. Están sesgados por la implementación.
- "Este caso es diferente" es una racionalización.
- Tests que pasan de inmediato sin haber fallado primero no sirven.

## Red flags — parar y empezar de cero

Si cualquiera de estas frases cruza por la cabeza, es señal de parar:

- "Voy a escribir el código primero y luego los tests"
- "Ya sé que funciona, los tests son un trámite"
- "Este módulo es demasiado simple para necesitar tests"
- "El tiempo no da para TDD en este caso"

Todas son racionalizaciones. La deuda técnica que generan supera siempre
el tiempo que supuestamente ahorran.

## Bugs

Al encontrar un bug:

1. Escribir un test que reproduzca el bug y FALLE.
2. Verificar que el test falla por la razón correcta.
3. Corregir el bug.
4. Verificar que el test ahora PASA.
5. Verificar que el resto de tests siguen pasando.
6. Commit con referencia al bug.

Nunca corregir un bug sin un test que lo reproduzca.
Sin el test, el bug puede volver sin que nadie lo detecte.

## Reportar al finalizar

Al completar la tarea reportar al Supervisor:
```
Estado: DONE / DONE_WITH_CONCERNS
Tests añadidos: N
Tests pasando: N/N
Archivos modificados: [lista]
Commit: [SHA]
```
