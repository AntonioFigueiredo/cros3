#!/bin/bash

mkdir -p pkgs
mv *-debpkg/*.deb pkgs/
apt -y update
ERRCODE=0

find . -name "*.deb" -exec cp {} ./pkgs/ \;
apt -y install ./pkgs/* || ERRCODE=$?
find /var/lib/dkms/ -iname "make.log" -exec grep -H . {} \;
exit ${ERRCODE}
