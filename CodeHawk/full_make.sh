#!/bin/bash
set -e
make -C CH_extern/extlib
make -C CH_extern/camlzip
make -C CH/chlib
make -C CH/chutil
make -C CH/xprlib
make -C CH_gui
make -C CHC/cil-1.7.3-develop
make -C CHC/cchcil
make -C CHC/cchlib
make -C CHC/cchpre
make -C CHC/cchanalyze
make -C CHC/cchcmdline
make -C CHC/cchgui
make -C CHB/bchlib
make -C CHB/bchlibpe
make -C CHB/bchlibelf
make -C CHB/bchlibx86
make -C CHB/bchlibmips32
make -C CHB/bchanalyze
make -C CHB/bchcmdline
make -C CHB/bchgui
make -C CHJ/jchlib
make -C CHJ/jchpre
make -C CHJ/jchsys
make -C CHJ/jchpoly
make -C CHJ/jchfeatures
make -C CHJ/jchmuse
make -C CHJ/jchcost
make -C CHJ/jchcmdline
make -C CHJ/jchstac
make -C CHJ/jchstacgui