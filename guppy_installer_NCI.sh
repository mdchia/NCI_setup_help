#!/bin/bash

# Settings

# Ensure all paths are writable
# Caution: Assumes that Guppy is packaged as an "ont-guppy" folder

# Copy link from the "Linux 64-bit GPU" download button in Community
# https://community.nanoporetech.com/downloads
guppyURL=https://mirror.oxfordnanoportal.com/software/analysis/ont-guppy_3.3.0_linux64.tar.gz

# Path to guppy folder install
# (creates "ont-guppy" folder in this path)
# (and downloads initial .tar to this folder)
# Use trailing /
guppyInstallPath=/g/data/xe2/opt/apps/guppy330/

# Path to guppy module file
# (creates a new module file at this location)
guppyModule=/g/data/xe2/opt/modules/guppy/3.3.0

mkdir -p $guppyInstallPath
pushd $guppyInstallPath
wget $guppyURL

# ${guppyURL##*/} should just get the filename e.g. ont-guppy_3.3.0_linux64.tar.gz
tar -xvf ${guppyURL##*/}
rm ${guppyURL##*/}

cat <<EOT > $guppyModule
#%Module######################################################################
source /opt/Modules/extensions/extensions.tcl

proc ModulesHelp { } {
        global version
        puts stderr "Provides guppy"
}

module-whatis "guppy basecaller"

prepend-path PATH ${guppyInstallPath}ont-guppy/bin
EOT

popd