# 🤝 Contributing Guide

¡Gracias por querer contribuir a **OpenClaw 0 → 100%**!

## Cómo Contribuir

### 1. Reportar Bugs

Si encontrás un error en la guía o el script:

1. Buscá si el issue ya existe en [Issues](https://github.com/azazelpy/openclaw-0-100/issues)
2. Si no existe, creá uno nuevo con:
   - Descripción clara del problema
   - Pasos para reproducir
   - Versión de OpenClaw que estás usando
   - Sistema operativo

### 2. Sugerir Mejoras

¿Tenés una idea para mejorar la guía?

1. Abrí un [Issue](https://github.com/azazelpy/openclaw-0-100/issues) con la etiqueta `enhancement`
2. Describí tu idea y por qué sería útil
3. Esperá feedback de la comunidad

### 3. Enviar Pull Requests

1. **Fork** el repositorio
2. **Creá una rama** para tu feature: `git checkout -b feature/mi-mejora`
3. **Hacé tus cambios** y probalos
4. **Commit** con mensajes descriptivos: `git commit -am "Agregar sección sobre XYZ"`
5. **Push** a tu fork: `git push origin feature/mi-mejora`
6. **Abrí un Pull Request** en GitHub

## Estándares de Código

### Scripts (Bash)

```bash
#!/bin/bash
# Descripción del script
# Autor: Tu Nombre
# Fecha: YYYY-MM-DD

set -e  # Salir en caso de error

# Usar funciones para reutilizar código
mi_funcion() {
    echo "Hola"
}

# Validar inputs
if [[ -z "$1" ]]; then
    echo "Error: Se requiere un argumento"
    exit 1
fi
```

### Markdown

- Usar encabezados jerárquicos (`#`, `##`, `###`)
- Tablas para datos estructurados
- Code blocks con lenguaje especificado
- Links descriptivos (no "click aquí")

### PDF/HTML

- Mantener consistencia con el estilo original
- Usar la paleta de colores existente
- Asegurar legibilidad en impresión

## Áreas de Contribución

### 📚 Documentación

- Corregir errores ortográficos o de gramática
- Actualizar comandos obsoletos
- Agregar ejemplos prácticos
- Traducir a otros idiomas

### 🔧 Scripts

- Mejorar la UX del quick-start.sh
- Agregar nuevas fases o checks
- Optimizar rendimiento
- Agregar soporte para más plataformas

### 🔐 Seguridad

- Reportar vulnerabilidades
- Sugerir mejoras de hardening
- Actualizar CVEs y versiones mínimas

### 🎨 Diseño

- Mejorar el formato del PDF
- Agregar diagramas o ilustraciones
- Crear versión web interactiva

## Proceso de Review

1. **Automated Checks**: Shell syntax, Markdown linting
2. **Human Review**: Al menos 1 maintainer debe aprobar
3. **Testing**: Probar cambios en entorno real
4. **Merge**: Se hace squash merge para mantener historial limpio

## Código de Conducta

- Sé respetuoso con otros contribuidores
- No hacer spam o autopromoción excesiva
- Dar crédito donde corresponde
- Mantener el foco en ayudar a la comunidad

## Reconocimientos

Los contribuidores serán listados en el README.md bajo la sección "Contributors".

---

**Preguntas?** Abrí un issue o contactá a @azazelpy en Telegram.

**Inspirado en:** [OpenClaw](https://github.com/openclaw/openclaw), [openclaw-ops](https://github.com/cathrynlavery/openclaw-ops)

---

🦞 **¡Exfoliá, exfoliá!**
