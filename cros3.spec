Name:           cros3
Version:        0.1
Release:        0%{?dist}
Summary:        Cros3 kernel module
License:        GPL-2.0+
URL:            https://github.com/BGO-OD/cros3
Source0:        %{name}-%{version}.tar.bz2
BuildRequires:  dkms, kernel-devel, udev
BuildRequires:  gcc, make
BuildRoot:      %{_tmppath}/%{name}-%{version}-build

%description
Kernel driver for the cros3 module

%prep
%setup -q

%build
# Standard DKMS build
%{__make} -C /lib/modules/%{kernel_version}/build M=%{_builddir}/%{name}-%{version} modules

%install
# Install kernel module
mkdir -p %{buildroot}/lib/modules/%{kernel_version}/extra
install -m 644 cros3.ko %{buildroot}/lib/modules/%{kernel_version}/extra/

# Install DKMS files
mkdir -p %{buildroot}/usr/src/%{name}-%{version}/
cp -r * %{buildroot}/usr/src/%{name}-%{version}/

%post
/sbin/depmod -a

%files
/lib/modules/%{kernel_version}/extra/cros3.ko
/usr/src/%{name}-%{version}/

%changelog
* Wed Apr 16 2024 Your Name <email@example.com>
- Initial package