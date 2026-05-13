# Makefile for tauri-client-book.
#
# Flat layout: Sphinx sources live at the repository root, Poetry metadata
# lives at the root, and build output goes to ./build. The Poetry virtualenv
# lives at ./.venv (configured via poetry.toml).
#
# Every build / serve / lint target is routed through `poetry run` so the
# toolchain never pollutes the ambient Python. When called from inside
# `poetry shell` / `poetry env activate` (POETRY_ACTIVE=1), the `poetry run`
# prefix is stripped automatically.
#
# Quick start:
#
#   make setup            # poetry install (one-time)
#   make html             # sphinx-build (strict)
#   make serve            # serve build/html/ at http://localhost:7801
#   make livehtml         # live-reload preview via sphinx-autobuild
#   make lint             # structural Sphinx check
#   make clean            # remove build/
#   make check            # lint + full html build
#
# Every short target is mirrored as `book-<name>` for compatibility with
# external callers / prior docs that used the delegator layout.

SPHINXOPTS      ?= -W --keep-going -n
SPHINXBUILD     ?= sphinx-build
SPHINXAUTOBUILD ?= sphinx-autobuild
SOURCEDIR       ?= .
BUILDDIR        ?= build
PORT            ?= 7801
HOST            ?= 127.0.0.1

POETRY          ?= poetry
ifndef POETRY_ACTIVE
SPHINXBUILD     := $(POETRY) run $(SPHINXBUILD)
SPHINXAUTOBUILD := $(POETRY) run $(SPHINXAUTOBUILD)
PY              := $(POETRY) run python
else
PY              := python
endif

.DEFAULT_GOAL := help

.PHONY: help check \
        setup install export-requirements shell \
        clean \
        html \
        livehtml serve \
        lint linkcheck \
        publish publish-status \
        book-setup book-install book-export-requirements book-shell \
        book-clean \
        book-html \
        book-livehtml book-serve \
        book-lint book-linkcheck \
        book-publish book-publish-status

help: ## Show available targets
	@echo 'tauri-client-book — Sphinx build targets (auto-wrapped in `poetry run`)'
	@echo ''
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z][a-zA-Z0-9_-]*:.*?## / {printf "  %-26s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ''
	@echo 'Tunable variables: PORT=$(PORT) HOST=$(HOST) SPHINXOPTS="$(SPHINXOPTS)"'

setup: install ## Install dependencies for local book builds

install: ## Create/refresh the Poetry virtualenv
	$(POETRY) install --with dev
	@echo "  -> poetry env ready at $$($(POETRY) env info --path 2>/dev/null || echo .venv)"
	@echo "  -> after renaming the repo directory: $(POETRY) env remove --all && $(POETRY) install --with dev  (fixes stale .venv shebangs)"

export-requirements: ## Refresh requirements-docs.txt from poetry.lock (pip fallback)
	@$(POETRY) self show plugins 2>/dev/null | grep -q poetry-plugin-export \
		|| { echo "  !! poetry-plugin-export not installed."; \
		     echo "     install it once with:  poetry self add poetry-plugin-export"; \
		     exit 1; }
	$(POETRY) export --without-hashes --with dev -f requirements.txt -o requirements-docs.txt
	@echo "  -> wrote requirements-docs.txt"

shell: ## Drop into a sub-shell with the venv activated
	@# Poetry 2.x moved `poetry shell` into the poetry-plugin-shell plugin;
	@# prefer the built-in `poetry env activate` when available.
	@if $(POETRY) env activate --help >/dev/null 2>&1; then \
		$(POETRY) env activate; \
	elif $(POETRY) shell --help >/dev/null 2>&1; then \
		$(POETRY) shell; \
	else \
		echo "  !! neither 'poetry env activate' nor 'poetry shell' is available."; \
		echo "     install the shell plugin:  poetry self add poetry-plugin-shell"; \
		exit 1; \
	fi

clean: ## Remove build/ output
	rm -rf "$(BUILDDIR)"

html: ## Build the HTML tree at build/html/ in strict mode
	$(SPHINXBUILD) -b html "$(SOURCEDIR)" "$(BUILDDIR)/html" $(SPHINXOPTS)

livehtml: ## Serve with live reload
	$(SPHINXAUTOBUILD) --host $(HOST) --port $(PORT) "$(SOURCEDIR)" "$(BUILDDIR)/html" $(SPHINXOPTS)

serve: ## Serve build/html/ statically
	@if [ ! -d "$(BUILDDIR)/html" ]; then \
		echo "  !! $(BUILDDIR)/html/ does not exist — run 'make html' first"; \
		exit 1; \
	fi
	@echo "  -> serving $(BUILDDIR)/html/ at http://$(HOST):$(PORT)/"
	@echo "     (Ctrl-C to stop)"
	$(PY) -m http.server $(PORT) --bind $(HOST) --directory "$(BUILDDIR)/html"

lint: ## Run a strict structural Sphinx check without writing HTML
	$(SPHINXBUILD) -b dummy "$(SOURCEDIR)" "$(BUILDDIR)/dummy" $(SPHINXOPTS)

linkcheck: ## Report dead external links without failing the main build
	$(SPHINXBUILD) -b linkcheck "$(SOURCEDIR)" "$(BUILDDIR)/linkcheck"

check: lint html ## Lint + full build

# ---------------------------------------------------------------------------
# Publish to GitHub Pages (gh-pages branch approach)
# ---------------------------------------------------------------------------
#
# Build the HTML locally with `make check`, then force-push build/html/ onto
# a dedicated `gh-pages` branch of the GitHub remote. GitHub Pages must be set
# to: Settings -> Pages -> Source: "Deploy from a branch", Branch: gh-pages / root.

PUBLISH_REMOTE       ?= origin
PUBLISH_PAGES_BRANCH ?= gh-pages
PUBLISH_SLUG         ?= $(shell git remote get-url $(PUBLISH_REMOTE) 2>/dev/null | sed -E -e 's|^git@github\.com:||' -e 's|^https?://github\.com/||' -e 's|\.git$$||')
PUBLISH_OWNER        ?= $(firstword $(subst /, ,$(PUBLISH_SLUG)))
PUBLISH_REPO         ?= $(lastword $(subst /, ,$(PUBLISH_SLUG)))

publish: check ## Build, then force-push build/html/ to the gh-pages branch
	@if [ ! -d "$(BUILDDIR)/html" ]; then \
		echo "  !! $(BUILDDIR)/html/ missing after 'make check'"; exit 1; \
	fi
	@REMOTE_URL="$$(git remote get-url $(PUBLISH_REMOTE) 2>/dev/null)"; \
	if [ -z "$$REMOTE_URL" ]; then \
		echo "  !! could not resolve remote '$(PUBLISH_REMOTE)'"; exit 1; \
	fi; \
	TMPDIR="$$(mktemp -d)"; \
	trap 'rm -rf "$$TMPDIR"' EXIT; \
	cp -R "$(BUILDDIR)/html/." "$$TMPDIR/"; \
	touch "$$TMPDIR/.nojekyll"; \
	echo "  -> publishing $(BUILDDIR)/html/ to $$REMOTE_URL ($(PUBLISH_PAGES_BRANCH))"; \
	cd "$$TMPDIR" && \
		git init -q && \
		git checkout -q -b "$(PUBLISH_PAGES_BRANCH)" && \
		git add -A && \
		git -c user.name="$$(git -C "$(CURDIR)" config user.name)" \
		    -c user.email="$$(git -C "$(CURDIR)" config user.email)" \
		    commit -q -m "publish: $$(date -u +%Y-%m-%dT%H:%M:%SZ)" && \
		git push --force "$$REMOTE_URL" "$(PUBLISH_PAGES_BRANCH):$(PUBLISH_PAGES_BRANCH)"
	@echo ""
	@echo "  -> deployed site:  https://$(PUBLISH_OWNER).github.io/$(PUBLISH_REPO)/"
	@echo "     (first publish? enable Pages: https://github.com/$(PUBLISH_SLUG)/settings/pages"
	@echo "      -> Source: 'Deploy from a branch' -> Branch: '$(PUBLISH_PAGES_BRANCH)' / root)"

publish-status: ## Print URLs for Pages settings, gh-pages branch, and deployed site
	@if [ -z "$(PUBLISH_SLUG)" ]; then \
		echo "  !! could not detect github.com slug from remote '$(PUBLISH_REMOTE)'"; \
		exit 1; \
	fi
	@echo "  Pages settings:  https://github.com/$(PUBLISH_SLUG)/settings/pages"
	@echo "  gh-pages branch: https://github.com/$(PUBLISH_SLUG)/tree/$(PUBLISH_PAGES_BRANCH)"
	@echo "  Deployed site:   https://$(PUBLISH_OWNER).github.io/$(PUBLISH_REPO)/"

book-setup: setup
book-install: install
book-export-requirements: export-requirements
book-shell: shell
book-clean: clean
book-html: html
book-livehtml: livehtml
book-serve: serve
book-lint: lint
book-linkcheck: linkcheck
book-publish: publish
book-publish-status: publish-status

