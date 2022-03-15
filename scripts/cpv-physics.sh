#!/usr/bin/env bash

# set -x;
set -e;
set -u;

WF_NAME=cpv-physics
export DPL_CONDITION_BACKEND="http://127.0.0.1:8084"
DPL_PROCESSING_CONFIG_KEY_VALUES="NameConf.mCCDBServer=http://127.0.0.1:8084;"

cd ..

# DPL command to generate the AliECS dump
o2-dpl-raw-proxy -b --session default --dataspec 'x0:CPV/RAWDATA;dd:FLP/DISTSUBTIMEFRAME/0' --readout-proxy '--channel-config "name=readout-proxy,type=pull,method=connect,address=ipc:///tmp/stf-builder-dpl-pipe-0,transport=shmem,rateLogging=1"' \
<<<<<<< HEAD
    | o2-cpv-reco-workflow -b --session default --input-type raw --output-type digits --disable-root-input --disable-root-output --disable-mc --severity warning --configKeyValues "${DPL_PROCESSING_CONFIG_KEY_VALUES}" \
=======
    | o2-cpv-reco-workflow -b --session default --input-type raw --output-type digits --disable-root-input --disable-root-output --disable-mc --severity warning --condition-backend localhost:8084 \
>>>>>>> 27dbe988... Cpv noise calibration (#265)
    | o2-dpl-output-proxy -b --session default --dataspec 'x0:CPV/RAWDATA;DIG:CPV/DIGITS/0;DTR:CPV/DIGITTRIGREC/0;ERR:CPV/RAWHWERRORS/0;dd:FLP/DISTSUBTIMEFRAME/0' --dpl-output-proxy '--channel-config "name=downstream,type=push,method=bind,address=ipc:///tmp/stf-pipe-0,rateLogging=1,transport=shmem"' --o2-control $WF_NAME
