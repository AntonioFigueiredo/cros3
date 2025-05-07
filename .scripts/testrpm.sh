#!/bin/bash
set -e
set -o pipefail

mkdir -p rpmPkgs

find . -type f -name "*.rpm" -exec mv {} rpmPkgs/ \;
if [ -z "$(ls -A rpmPkgs/*.rpm 2>/dev/null)" ]; then
  echo "ERROR: No .rpm files found in artifacts!"
  exit 1
fi

for rpm in pkgs/*.rpm; do
  echo "Installing $rpm"
  dnf -y install "./$rpm" || ERRCODE=$?
done

dkms status | grep cros3