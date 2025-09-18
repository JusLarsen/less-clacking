.PHONY: lint format lint-shell lint-markdown help

help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

lint: lint-shell lint-markdown ## Run all linters

lint-shell: ## Lint shell scripts
	@echo "Linting shell scripts..."
	@shellcheck install.sh scripts/*.sh
	@shfmt -d -i 2 -ci install.sh scripts/*.sh

lint-markdown: ## Lint markdown files
	@echo "Linting markdown files..."
	@markdownlint README.md CLAUDE.md

format: ## Auto-format code
	@echo "Formatting shell scripts..."
	@shfmt -w -i 2 -ci install.sh scripts/*.sh
	@echo "Formatting markdown files..."
	@markdownlint --fix README.md CLAUDE.md

install-linters: ## Install linting tools via Homebrew
	@echo "Installing linters..."
	@command -v shellcheck >/dev/null 2>&1 || brew install shellcheck
	@command -v shfmt >/dev/null 2>&1 || brew install shfmt
	@command -v markdownlint >/dev/null 2>&1 || npm install -g markdownlint-cli