
Name:           HelloApp
Version:        1.0
Release:        1%{?dist}
Summary:        HSBC HelloApp demo
Vendor:         HSBC w/Jan Thomas Moldung
License:        BSD, GPL+ or Artistic
URL:            https://alm-github.systems.uk.hsbc/45040746/JTM-HelloApp
#Source0:        https://alm-github.systems.uk.hsbc/45040746/JTM-HelloApp
Source0:        perl-server.tar.gz

#BuildRequires:
Requires:       /usr/bin/bash
Prefix:        %{_prefix}
#Packager:      jan.thomas.moldung@hsbc.com
#BuildRoot:    %[_tmppath}/%[name}-root
BuildArch:     noarch
BuildRequires: sed
Requires:      perl
Requires:      bash

%description
An app...

%prep
%setup -c -q
# We have no source, so nothing here


%build
# % configure
#mkae %{?_smp_mflags}
sed -i -e "/MYVERSION.*=/s/=.*$/= '%{version}-%{release}';/" perl-server.pl
cat > hello-world.sh << EOF
#!/usr/bin/bash
echo "Hello, World!"
echo "(This is version %{version}-%{release}"
EOF

make


%install
#rm -rf $RPM_BUILD_ROOT
# % mkae_install
mkdir -p %{buildroot}/usr/local/bin/
install --mode=755 --group=root --owner=root hello-world.sh %{buildroot}/usr/local/bin/hello-world.sh

%files
#&defattr(-,root,root)
%defattr(0755,root,root)
%attr(0755, root, root) /usr/local/bin/*
# % dco

%pre
# Run during install but prior to installation of files
echo "% pre"

%post
# Run after rpm installation
echo "% post: rpm installed"

%postrun
# Run after rpm is uninstalled
echo "% postrun: Uninstalled!"

#&clean
# Clean up after rpmbuild
#/usr/bin/rm -Rfv %[buildroot} %[_builddir}/* %[_srcrpmdir}/*

%changelog
* Wed Jun 19 2019 Jan Thomas Moldung <jan.thomas.moldung@hsbc.com> - 1.0-1
- Initial release
