# Makefile automatic variables:
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables
#
# http://web.mit.edu/gnu/doc/html/make_toc.html
# http://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/
# http://nuclear.mutantstargoat.com/articles/make/
#
# rpm macros:
# https://docs.fedoraproject.org/en-US/packaging-guidelines/RPMMacros/

# %{_topdir} = %{getenv:HOME}/rpmbuild
# https://possiblelossofprecision.net/?p=1229

RPMBUILDFLAGS = -ba --clean --define "_topdir $(CURDIR)"
BUILARCH = noarch

HelloApp: RPMS/$(BUILARCH)/HelloApp-1.0-1.el7.$(BUILARCH).rpm RPMS/$(BUILARCH)/HelloApp-2.1-4.el7.$(BUILARCH).rpm SOURCES/perlserver.tar.gz
        @echo
        @echo
        @echo Success! RPMS/$(BUILARCH)/HelloApp-1.0-1.el7.$(BUILARCH).rpm and RPMS/$(BUILARCH)/HelloApp-2.1-4.el7.$(BUILARCH).rpm are build
        @echo

RPMS/$(BUILARCH)/HelloApp-1.0-1.el7.$(BUILARCH).rpm: SPECS/HelloApp-v1.0-1.spec SOURCES/perlserver.tar.gz
        /usr/bin/rpmbuild $(RPMBUILDFLAGS) $?

RPMS/$(BUILARCH)/HelloApp-2.1-4.el7.$(BUILARCH).rpm: SPECS/HelloApp-v2.1-4.spec SOURCES/perlserver.tar.gz
        /usr/bin/rpmbuild $(RPMBUILDFLAGS) $?

rpmbuild: yuminst
inst: yuminst
setup: yuminst
yum: yuminst
yuminst:
	/usr/bin/yum -y install rpm-build
	@/usr/bin/yum -y install rpmdevtools rpmlint rpm-build

SOURCES/perlserver.tar.gz:
	# $(MAKECMDGOALS)
	#$(MAKE) -C $@ rpmsource
	cd SOURCES && make rpmsource

# Directories created by rpmdev-setuptree
RPMDIRS = RPMS SRPMS BUILD SOURCES SPECS

dir: mkdir
dirs: mkdir
mkdir: $(RPMDIRS)
$(RPMDIRS):
	mkdir -v $@

perlserver:
	echo hei hei

.PHONY : clean $(SUBDIRS)

clean :
	/usr/bin/rm -Rfv {RPMS,SRPMS,BUILD}/* SOURCES/perlserver.tar.gz
# -rm ...

