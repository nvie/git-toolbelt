prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
INSTALL = install

.PHONY: all
all:
	@echo "Run 'make install' to install git-toolbelt"

.PHONY: install
install:
	$(INSTALL) -d $(DESTDIR)$(bindir)
	for script in git-*; do \
		$(INSTALL) -m 0755 $$script $(DESTDIR)$(bindir)/; \
	done

.PHONY: uninstall
uninstall:
	for script in git-*; do \
		rm -f $(bindir)/$$script; \
	done
