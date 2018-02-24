#!/usr/bin/make -f

# force use of Bash
SHELL := /bin/bash
INTERACTIVE=true

ifndef VERBOSE
.SILENT:
endif


.PHONY: default \
	help

help:
	printf "Available targets:\n--\n"
	grep --perl-regexp --only-matching '^([\w-]+)(?=:)' [mM]akefile | sort
	printf -- "--\n"

reset:
	rm build/ -rf; mkdir -p build/svg

install-font:  # copy font to local font directory
	cp build/*.{otf,ttf,woff,woff2} ~/.local/share/fonts/

remove-font:
	for font in build/*; do \
		rm --force ~/.local/share/fonts/ruby-font-creator.ttf; \
	done
