#!/bin/bash -x

yum install -y epel-release
yum install -y gcc make rpm-build rpmdevtools dkms yum-utils kernel-devel kernel-abi-stablelists kernel-rpm-macros udev

rpmdev-setuptree

KERNEL_VER=$(uname -r)

VERSION="0.1"

mv source_dir/src cros3-${VERSION}
tar cjf cros3-${VERSION}.tar.bz2 cros3-${VERSION}
cp *.tar.bz2 ~/rpmbuild/SOURCES/
cp source_dir/*.spec .

yum-builddep -y cros3.spec

rpmbuild -ba --define "kernel_version ${KERNEL_VER}" cros3.spec

cd ~
find
ls -la

mkdir -p ${GITHUB_WORKSPACE}/rpm-artifacts
cp -r ~/rpmbuild/RPMS ${GITHUB_WORKSPACE}/rpm-artifacts/
cp -r ~/rpmbuild/SRPMS ${GITHUB_WORKSPACE}/rpm-artifacts/
