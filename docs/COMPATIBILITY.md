# Compatibilidad entre repositorios

## Versiones

| ETC-El-Septeto-Calavera | ETC-System-Agents | Compatible |
|-------------------------|-------------------|------------|
| v3.0.0                  | v1.0.0            | ✅ |
| v2.3.0                  | v1.0.0            | ✅ |
| v2.2.0                  | v1.0.0            | ✅ |
| v2.1.0                  | v1.0.0            | ✅ |
| v2.0.0                  | v1.0.0            | ✅ |
| < v2.0                  | cualquiera        | ❌ (System Agents no existía) |

## Reglas de compatibilidad

1. **MAJOR changes** en un repo requieren MAJOR en el otro si hay cambios de interfaz
2. **MINOR changes** son compatibles hacia atrás dentro del mismo MAJOR
3. Siempre instalar la última versión de ambos repos juntos
