# Point PATH at this working copy, so edits here take effect immediately.
# This is a developer install in the sense of `npm link` or `pip install -e`:
# it does not copy anything, so the links die if this directory moves.
#
#   make link     link $(PREFIX)/git-* -> the scripts in this directory
#   make unlink   remove those links again
#   make test     run the test suite (sandboxed, see test/run)
#
# No sudo. PREFIX defaults to whichever of ~/.local/bin or ~/bin is already on
# your PATH, so linking takes effect in shells you already have open rather
# than only in new ones. Override it if you keep binaries elsewhere:
#
#   make link PREFIX=~/opt/bin

SCRIPTS := $(wildcard git-*)
PROBE := $(firstword $(SCRIPTS))

# First of these that is already on PATH, else the first as a fallback.
CANDIDATES := $(HOME)/.local/bin $(HOME)/bin
ON_PATH := $(firstword $(filter $(subst :, ,$(PATH)),$(CANDIDATES)))
PREFIX ?= $(if $(ON_PATH),$(ON_PATH),$(firstword $(CANDIDATES)))

.DEFAULT_GOAL := help
.PHONY: help link unlink test

help:
	@echo "make link      link $(words $(SCRIPTS)) commands into $(PREFIX)"
	@echo "make unlink    remove them again"
	@echo "make test      run the test suite"

link:
	@mkdir -p "$(PREFIX)"
	@linked=0; \
	for s in $(SCRIPTS); do \
		ln -sfn "$(CURDIR)/$$s" "$(PREFIX)/$$s" 2>/dev/null; \
		[ -L "$(PREFIX)/$$s" ] && linked=$$((linked + 1)); \
	done; \
	echo "Linked $$linked command(s) into $(PREFIX)"; \
	[ "$$linked" -eq $(words $(SCRIPTS)) ] || exit 1
	@found=$$(command -v $(PROBE) 2>/dev/null); \
	case "$$found" in "$(PREFIX)/$(PROBE)"|"$(CURDIR)"/*) exit 0;; esac; \
	echo >&2; \
	echo "warning: $(PROBE) resolves to $${found:-nothing}, not $(PREFIX)." >&2; \
	echo "         Put $(PREFIX) at the front of your PATH:" >&2; \
	echo '    fish:      fish_add_path --move $(PREFIX)' >&2; \
	echo '    bash/zsh:  export PATH="$(PREFIX):$$PATH"' >&2

unlink:
	@removed=0; \
	for link in "$(PREFIX)"/*; do \
		[ -L "$$link" ] || continue; \
		case "$$(readlink "$$link")" in \
			"$(CURDIR)"/*) rm "$$link"; removed=$$((removed + 1));; \
		esac; \
	done; \
	echo "Removed $$removed link(s) from $(PREFIX)"

test:
	@test/run
