#!/bin/bash -x
set -e
#dnf install -y epel-release

#KERNEL_VER=$(uname -r)
#dnf install -y "kernel-devel-${KERNEL_VER}"
dnf install -y kernel-devel kernel-headers
dnf install -y gcc make rpm-build rpmdevtools dkms dnf-utils kernel-abi-stablelists kernel-rpm-macros udev

rpmdev-setuptree

VERSION="0.1"

mv source_dir/src cros3-${VERSION}
tar -cvjf cros3-${VERSION}.tar.bz2 cros3-${VERSION}
cp *.tar.bz2 ~/rpmbuild/SOURCES/
cp source_dir/*.spec .
cp cros3.spec "$RPMBUILD_DIR/SPECS/"

dnf builddep -y cros3.spec

KERNEL_VERSION=$(uname -r)
rpmbuild -ba "$RPMBUILD_DIR/SPECS/cros3.spec" --define "kernel_version ${KERNEL_VERSION}"

#cd ~
#find
#ls -la

mkdir -p ${GITHUB_WORKSPACE}/rpm-artifacts
cp -r ~/rpmbuild/RPMS ${GITHUB_WORKSPACE}/rpm-artifacts/
cp -r ~/rpmbuild/SRPMS ${GITHUB_WORKSPACE}/rpm-artifacts/