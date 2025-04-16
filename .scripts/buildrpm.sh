#!/bin/bash -x

yum install -y epel-release

KERNEL_VER=$(uname -r)
yum install -y "kernel-devel-${KERNEL_VER}"
yum install -y gcc make rpm-build rpmdevtools dkms yum-utils kernel-abi-stablelists kernel-rpm-macros udev

rpmdev-setuptree

VERSION="0.1"

mv source_dir/src cros3-${VERSION}
tar cjf cros3-${VERSION}.tar.bz2 cros3-${VERSION}
cp *.tar.bz2 ~/rpmbuild/SOURCES/
cp source_dir/*.spec .

yum-builddep -y cros3.spec

rpmbuild -ba cros3.spec

cd ~
find
ls -la

mkdir -p ${GITHUB_WORKSPACE}/rpm-artifacts
cp -r ~/rpmbuild/RPMS ${GITHUB_WORKSPACE}/rpm-artifacts/
cp -r ~/rpmbuild/SRPMS ${GITHUB_WORKSPACE}/rpm-artifacts/
