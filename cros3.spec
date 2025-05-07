Name:           cros3
BuildRequires:  dkms, kernel-devel, gcc, make, udev
License:        GPL-2.0+
Summary:        cros3 kernel module
Version:        0.1
Release:        0%{?dist}
URL:            https://github.com/BGO-OD/cros3
Source0:        %{name}-%{version}.tar.bz2
BuildRoot:      %{_tmppath}/%{name}-%{version}-build

%description
Kernel driver for the cros3 module

%prep
%setup -q

%build
KERNEL_VERSION=$(rpm -q --qf "%{VERSION}-%{RELEASE}.%{ARCH}" kernel-devel)
make -C /usr/src/kernels/$KERNEL_VERSION M=$PWD modules

%install
KERNEL_VERSION=$(rpm -q --qf "%{VERSION}-%{RELEASE}.%{ARCH}" kernel-devel)
mkdir -p %{buildroot}/lib/modules/$KERNEL_VERSION/extra
install -m 644 cros3.ko %{buildroot}/lib/modules/$KERNEL_VERSION/extra/

%files
/lib/modules/*/extra/cros3.ko

%changelog