Name:           cros3
BuildRequires:  gcc, make, kernel-devel, elfutils-libelf-devel
License:        GPL-2.0+
Summary:        cros3 kernel module
Version:        0.1
Release:        0%{?dist}
URL:            https://github.com/BGO-OD/cros3
Source0:        %{name}-%{version}.tar.bz2
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
Requires(post): kmod
Requires(postun): kmod

%define debug_package %{nil}

%description
Kernel driver for the cros3 module

%prep
%setup -q

%build
mkdir -p built-kmods

for kdir in /usr/src/kernels/*; do
    [ -d "$kdir" ] || continue
    krel=$(basename "$kdir")

    mkdir -p "obj/$krel" "built-kmods/$krel"
    cp -a COPYING Makefile cros3.c cros3.h "obj/$krel/"
    make -C "$kdir" M="$PWD/obj/$krel" modules EXTRA_CFLAGS='-DRHEL_KERNEL'
    cp -a "obj/$krel/cros3.ko" "built-kmods/$krel/"
done

%install
rm -rf %{buildroot}

mkdir -p %{buildroot}/usr/src/%{name}-%{version}/
cp -a COPYING Makefile cros3.c cros3.h %{buildroot}/usr/src/%{name}-%{version}/

mkdir -p %{buildroot}/usr/share/licenses/%{name}
cp -a COPYING %{buildroot}/usr/share/licenses/%{name}/

for krel_dir in built-kmods/*; do
    [ -d "$krel_dir" ] || continue
    krel=$(basename "$krel_dir")
    mkdir -p %{buildroot}/lib/modules/$krel/extra/%{name}
    cp -a "$krel_dir"/*.ko %{buildroot}/lib/modules/$krel/extra/%{name}/
done

%post
for modules_dir in /lib/modules/*; do
    [ -d "$modules_dir/extra/%{name}" ] || continue
    /usr/sbin/depmod "$(basename "$modules_dir")" >/dev/null 2>&1 || :
done

%postun
for modules_dir in /lib/modules/*; do
    [ -d "$modules_dir" ] || continue
    /usr/sbin/depmod "$(basename "$modules_dir")" >/dev/null 2>&1 || :
done

%files
%defattr(-,root,root)
%license /usr/share/licenses/%{name}/COPYING
/lib/modules/*/extra/%{name}/*.ko
/usr/src/%{name}-%{version}


%changelog
