#

PACKAGE = autogenize

prefix = /usr/local
bindir = $(prefix)/bin
sharedir = $(prefix)/share
pkgsharedir = $(sharedir)/$(PACKAGE)

all: autogenize

autogenize: autogenize.in conf.sed
	sed -f conf.sed $< >$@.tmp
	mv -f $@.tmp $@

conf.sed: Makefile
	(	echo "s,@pkgsharedir@,$(pkgsharedir),g;"; \
	) >$@.tmp
	mv -f $@.tmp $@

install: all
	test -d $(bindir) || mkdir -vp $(bindir)
	install -m 755 -T autogenize $(bindir)/autogenize
	test -d $(pkgsharedir) || mkdir -vp $(pkgsharedir)
	install -T autogen.in $(pkgsharedir)/autogen.in
