#!/bin/sh
set -eu

sed '/^\tgit-.*/d' Makefile > Makefile.new

for source in git-*; do
    printf '\t%s \\\n' ${source} >> Makefile.new
done

mv Makefile.new Makefile
