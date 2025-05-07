#!/bin/bash
set -e
set -o pipefail

mkdir -p rpmPkgs

find . -type f -name "*.rpm" -exec mv {} rpmPkgs/ \;
if [ -z "$(ls -A rpmPkgs/*.rpm 2>/dev/null)" ]; then
  echo "ERROR: No .rpm files found in artifacts!"
  exit 1
fi

ERRCODE=0
for rpm in rpmPkgs/*.rpm; do
  if [[ "$rpm" == *.src.rpm ]]; then
    echo "Skipping source RPM: $rpm"
    continue
  fi
  echo "Installing $rpm"
  dnf -y install "$rpm" || ERRCODE=$?
done

if [ $ERRCODE -ne 0 ]; then
  echo "ERROR: Failed to install one or more RPMs!"
  exit $ERRCODE
fi

dkms status | grep cros3