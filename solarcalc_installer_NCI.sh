#!/bin/bash

module load python3/3.7.4

# settings
export PYTHONPATH=/home/801/mc4673/myapps/pysolarcalc/lib/python3.7/site-packages/
export PATH=/home/801/mc4673/myapps/pysolarcalc/bin:$PATH
pysolarcalcModule=/home/801/mc4673/mymodules/pysolarcalc/latest
pysolarcalcInstallDir=/home/801/mc4673/myapps/

cd $pysolarcalcInstallDir

git clone https://gitlab.com/appf-anu/pysolarcalc.git

pip3 install -r requirements.txt --prefix ${pysolarcalcInstallDir}pysolarcalc/
./setup.py install --prefix ${pysolarcalcInstallDir}pysolarcalc

cat <<EOT > $pysolarcalcModule
#%Module######################################################################
source /opt/Modules/extensions/extensions.tcl
proc ModulesHelp { } {
        global version
        puts stderr "Provides pysolarcalc "
}
module-whatis "guppy basecaller"

soft-prereq python3/3.7.4
prepend-path PATH ${pysolarcalcInstallDir}pysolarcalc/bin
prepend-path PYTHONPATH ${pysolarcalcInstallDir}pysolarcalc/lib/python3.7/site-packages/
EOT