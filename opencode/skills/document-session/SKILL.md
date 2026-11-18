---
name: documentar-sesion
description: Documenta la sesion actual (chat, decisiones, implementaciones, complicaciones y soluciones). Solo se activa con frases que contengan "documenta este chat", "documenta esta decision", "documenta esta implementacion" o variantes similares en espanol. Crea un archivo Markdown en docs/ con nombre YYYY-MM-DD-{tema}.md. El contenido debe ser conciso, breve y optimo para que un agente lo lea rapido usando la menor cantidad de tokens posible.
---

# Documentar Sesion

## Objetivo
Crear un unico Markdown de minuta en `docs/` denso, breve y estructurado. Prioridad absoluta: maxima legibilidad para agentes + minimo consumo de tokens de contexto.

## Activacion
SOLO con frases explicitas que contengan:
- "documenta este chat"
- "documenta esta decision"
- "documenta esta implementacion"
- "documenta este desarrollo"
- o equivalente con "documenta" + contexto de sesion/decision/implementacion.

No activar por menciones casuales.

## Procedimiento

1. Crear `docs/` en raiz del proyecto si no existe.
2. Tema principal en kebab-case corto (ej. `auth-jwt`, `fix-login`).
3. Nombre: `YYYY-MM-DD-{tema}.md`.
4. Estructura EXACTA (omitir secciones vacias):

```markdown
# Minuta: {titulo corto}

| Campo | Valor |
|-------|-------|
| Fecha | YYYY-MM-DD |
| Tema | {tema} |
| Lenguajes | {lista} |
| Frameworks/Libs | {lista} |
| Herramientas | {lista} |
| Versiones clave | {ej. node 20, python 3.12} |
| Estado final | {exito / parcial / bloqueado} |

## Contexto
{1-3 frases max}

## Decisiones
- {decision}: {razon 1 linea}

## Complicaciones y soluciones
- **Problema**: {1 linea}
  **Solucion**: {1 linea}

## Cambios realizados
- {archivo/componente}: {accion breve}

## Pendientes
- {item}

## Notas tecnicas
{config, flags, comandos criticos — solo lo esencial}

