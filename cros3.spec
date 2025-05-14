Name:           cros3
BuildRequires:  dkms, kernel-devel, gcc, make, udev
License:        GPL-2.0+
Summary:        cros3 kernel module
Version:        0.1
Release:        0%{?dist}
URL:            https://github.com/BGO-OD/cros3
Source0:        %{name}-%{version}.tar.bz2
BuildRoot:      %{_tmppath}/%{name}-%{version}-build

%define debug_package %{nil}

%description
Kernel driver for the cros3 module

%prep
%setup -q

%build
for kver in $(ls /usr/src/kernels); do
    mkdir -p obj/$kver
    cp -a * obj/$kver/
    make -C /usr/src/kernels/$kver M=$PWD/obj/$kver modules
done

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/lib/modules
for kver in $(ls /usr/src/kernels); do
    make -C /usr/src/kernels/$kver M=$PWD/obj/$kver modules_install INSTALL_MOD_PATH=%{buildroot}
done
# Strip unneeded symbols
find %{buildroot}/lib/modules -name '*.ko' -exec strip --strip-unneeded {} +

%files
%defattr(-,root,root,-)
/lib/modules/*/extra/*.ko

%changelog