Name:           cros3
Version:        0.1
Release:        0%{?dist}
Summary:        Cros3 kernel module

BuildRequires:  dkms, kernel-devel

%description
Cros3 kernel module

%prep
%setup -q

%build
make -C /lib/modules/%{kernel_version}/build M=%{_builddir}/%{name}-%{version}/obj modules

%install
mkdir -p %{buildroot}/lib/modules/%{kernel_version}/extra
install -m 755 obj/cros3.ko %{buildroot}/lib/modules/%{kernel_version}/extra/

%files
/lib/modules/%{kernel_version}/extra/cros3.ko