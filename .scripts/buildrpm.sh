#!/bin/bash -x
set -e

rpmdev-setuptree

VERSION="0.1"

mv source_dir/src cros3-${VERSION}
tar -cvjf cros3-${VERSION}.tar.bz2 cros3-${VERSION}
cp *.tar.bz2 ~/rpmbuild/SOURCES/
cp source_dir/*.spec .

dnf builddep -y cros3.spec

KERNEL_VERSION=$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}' kernel-devel)
echo "DEBUG: Using KERNEL_VERSION=$KERNEL_VERSION"

KERNEL_SRC="/usr/src/kernels/${KERNEL_VERSION}"
KERNEL_BUILD="/lib/modules/${KERNEL_VERSION}/build"
if [ ! -e "$KERNEL_BUILD" ]; then
  echo "Creating symlink: $KERNEL_BUILD -> $KERNEL_SRC"
  mkdir -p "$(dirname "$KERNEL_BUILD")"
  ln -s "$KERNEL_SRC" "$KERNEL_BUILD"
fi

rpmbuild -ba cros3.spec --define "kernel_version ${KERNEL_VERSION}"

mkdir -p ${GITHUB_WORKSPACE}/rpm-artifacts
cp -r ~/rpmbuild/RPMS ${GITHUB_WORKSPACE}/rpm-artifacts/
cp -r ~/rpmbuild/SRPMS ${GITHUB_WORKSPACE}/rpm-artifacts/