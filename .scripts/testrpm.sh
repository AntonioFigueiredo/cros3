#!/bin/bash
set -e
set -o pipefail

yum install -y ~/rpmbuild/RPMS/*/*.rpm

dkms status | grep cros3