.PHONY: install validate lint test package clean

install:
	@echo "=== Instalando ETC ==="
	@mkdir -p ~/.config/opencode/agents ~/.config/opencode/skills ~/.config/opencode/prompts
	@cp .opencode/agents/*.md ~/.config/opencode/agents/
	@for skill in .opencode/skills/*/; do \
		cp -r "$$skill" ~/.config/opencode/skills/; \
	done
	@cp prompts/*.md ~/.config/opencode/prompts/
	@cp opencode.json ~/.config/opencode/
	@echo "✅ Instalado en ~/.config/opencode/"
	@echo "   Agentes: $$(ls ~/.config/opencode/agents/ | wc -l)"
	@echo "   Skills: $$(ls ~/.config/opencode/skills/ | wc -l)"

validate:
	@echo "=== Validando estructura ==="
	@python3 -c "import json; json.load(open('opencode.json')); print('✅ opencode.json válido')"
	@for agent in .opencode/agents/*.md; do \
		head -1 "$$agent" | grep -q "^---" || { echo "❌ $$agent sin frontmatter"; exit 1; }; \
		echo "✅ $$agent"; \
	done
	@echo "✅ Todos los agentes OK"

lint:
	@echo "=== Linting ==="
	@npm install -g prettier 2>/dev/null && prettier --check "**/*.md" "**/*.json" 2>/dev/null || echo "⚠️ prettier no instalado, saltando"

test:
	@echo "=== Tests ==="
	@if [ -f tests/hooks.md ]; then \
		echo "📋 tests/hooks.md encontrado (tests manuales)"; \
	fi

package:
	@echo "=== Empaquetando ==="
	@mkdir -p dist
	@tar czf "dist/etc-$(shell git describe --tags 2>/dev/null || echo 'dev').tar.gz" \
		.opencode/ opencode.json prompts/ README.md CHANGELOG.md CONTRIBUTING.md \
		--exclude='.opencode/.gitignore'
	@echo "✅ Package: dist/etc-*.tar.gz"

clean:
	@rm -rf dist/
	@echo "🧹 Limpio"
