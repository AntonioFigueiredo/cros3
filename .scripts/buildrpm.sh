#!/bin/bash -x
set -e

rpmdev-setuptree

VERSION="0.1"

mv source_dir/src cros3-${VERSION}
tar -cvjf cros3-${VERSION}.tar.bz2 cros3-${VERSION}
cp *.tar.bz2 ~/rpmbuild/SOURCES/
cp source_dir/*.spec .

dnf builddep -y cros3.spec


rpmbuild -ba cros3.spec

mkdir -p ${GITHUB_WORKSPACE}/rpm-artifacts
cp -r ~/rpmbuild/RPMS ${GITHUB_WORKSPACE}/rpm-artifacts/
cp -r ~/rpmbuild/SRPMS ${GITHUB_WORKSPACE}/rpm-artifacts/