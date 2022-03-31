#!/usr/bin/env bash

#set -x;
set -e
set -u

# shellcheck disable=SC1091
source helpers.sh

QC_GEN_CONFIG_PATH="json://${PWD}/etc/fdd-qcmn.json"
QC_FINAL_CONFIG_PATH="consul-json://{{ consul_endpoint }}/o2/components/qc/ANY/any/fdd-qcmn"
QC_CONFIG_PARAM="qc_config_uri"

WF_NAME=fdd-qcmn-remote
export DPL_CONDITION_BACKEND="http://127.0.0.1:8084"
DPL_PROCESSING_CONFIG_KEY_VALUES="NameConf.mCCDBServer=http://127.0.0.1:8084;"

cd ..

o2-qc --config "$QC_GEN_CONFIG_PATH" --remote -b --o2-control "$WF_NAME"

add_config_variable "$QC_FINAL_CONFIG_PATH" "$QC_GEN_CONFIG_PATH" "$QC_CONFIG_PARAM" "$WF_NAME"

add_fmq_shmmonitor_role workflows/${WF_NAME}.yaml
add_qc_remote_machine_attribute workflows/${WF_NAME}.yaml alio2-cr1-qme02