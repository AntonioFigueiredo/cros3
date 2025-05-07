# #!/bin/bash -x
# set -e
# #dnf install -y epel-release

# KERNEL_VER=$(uname -r)
# #dnf install -y "kernel-devel-${KERNEL_VER}"
# dnf install -y kernel-devel kernel-headers
# dnf install -y gcc make rpm-build rpmdevtools dkms dnf-utils kernel-abi-stablelists kernel-rpm-macros udev

# rpmdev-setuptree

# VERSION="0.1"

# mv source_dir/src cros3-${VERSION}
# tar cjf cros3-${VERSION}.tar.bz2 cros3-${VERSION}
# cp *.tar.bz2 ~/rpmbuild/SOURCES/
# cp source_dir/*.spec .

# dnf builddep -y cros3.spec

# rpmbuild -ba cros3.spec

# cd ~
# find
# ls -la

# mkdir -p ${GITHUB_WORKSPACE}/rpm-artifacts
# cp -r ~/rpmbuild/RPMS ${GITHUB_WORKSPACE}/rpm-artifacts/
# cp -r ~/rpmbuild/SRPMS ${GITHUB_WORKSPACE}/rpm-artifacts/

#!/bin/bash
set -e

# Set RPM build directories
RPMBUILD_DIR=~/rpmbuild
mkdir -p "$RPMBUILD_DIR"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Version must match spec file
VERSION=0.1
ARCHIVE_NAME="cros3-${VERSION}.tar.gz"

# Create source tarball using git
echo "Creating source archive $ARCHIVE_NAME..."
git archive --format=tar.gz --prefix="cros3-${VERSION}/" -o "$RPMBUILD_DIR/SOURCES/$ARCHIVE_NAME" HEAD

# Copy the .spec file to SPECS
cp cros3.spec "$RPMBUILD_DIR/SPECS/"

# Build the RPM
rpmbuild -ba "$RPMBUILD_DIR/SPECS/cros3.spec"
