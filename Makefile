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
	for script in $(SOURCES); do \
		$(INSTALL) -m 0755 $$script $(DESTDIR)$(bindir)/; \
	done

.PHONY: uninstall
uninstall:
	for script in $(SOURCES); do \
		rm -f $(bindir)/$$script; \
	done

# Do not manually edit anything below this comment, it will be overwritten
SOURCES = \
	git-active-branches \
	git-autofixup \
	git-branches-containing \
	git-cherry-pick-to \
	git-cleanup \
	git-cleave \
	git-commit-to \
	git-committer-info \
	git-conflicts \
	git-contains \
	git-current-branch \
	git-delouse \
	git-drop-local-changes \
	git-fixup \
	git-fixup-with \
	git-has-local-changes \
	git-has-local-commits \
	git-initial-commit \
	git-is-ancestor \
	git-is-clean \
	git-is-dirty \
	git-is-headless \
	git-is-repo \
	git-last-commit-to-file \
	git-local-branch-exists \
	git-local-branches \
	git-local-commits \
	git-main-branch \
	git-merge-status \
	git-merged \
	git-merges-cleanly \
	git-modified \
	git-modified-since \
	git-push-current \
	git-recent-branches \
	git-remote-branch-exists \
	git-remote-branches \
	git-remote-tracking-branch \
	git-repo \
	git-root \
	git-separator \
	git-sha \
	git-shatter-by-file \
	git-show-skipped \
	git-skip \
	git-spinoff \
	git-stage-all \
	git-stash-everything \
	git-tag-exists \
	git-trash \
	git-undo-commit \
	git-undo-merge \
	git-unmerged \
	git-unskip \
	git-unstage-all \
	git-update-all \
	git-wip \
	git-workon \
