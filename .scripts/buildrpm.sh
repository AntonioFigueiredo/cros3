#!/bin/bash -x

yum install -y gcc rpm-build rpm-devel rpmlint make bash diffutils patch rpmdevtools dkms

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
