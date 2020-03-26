#!/bin/bash

# Write safe shell scripts
set -euf -o pipefail
# Keep environment clean
export LC_ALL="C"
# Set variables
readonly TMP_DIR="/tmp"
readonly TMP_OUTPUT="${TMP_DIR}/$$.out"
readonly TMP_PAYLOAD="${TMP_DIR}/$$.json"
readonly BASE_DIR="$(dirname "$(realpath "$0")")"
readonly MY_NAME="${0##*/}"

# Cleanup on exit
trap 'rm -rf ${TMP_OUTPUT}' \
  EXIT SIGHUP SIGINT SIGQUIT SIGPIPE SIGTERM

#export HOOK_ENTIRE_PAYLOAD='{"api_key":"API_KEY","other_args":[{"key":"somekey1","value":"somevalue1"},{"key":"somekey2","value":"somevalue2"},{"key":"HOOK_somekey3","value":"somevalue3"}],$
#export HOOK_API_KEY="API_KEY"
#export HOOK_TEMPLATE_URL="http://smth"

echo writing raw payload to $TMP_PAYLOAD

echo "${HOOK_ENTIRE_PAYLOAD}" >> "${TMP_PAYLOAD}"

DYNAMIC_PARAMS=$(echo ${HOOK_ENTIRE_PAYLOAD} | jq '.template_args' | jq -r "to_entries|map(\" -a \(.key)=\(.value|tostring)\")|join(\"\")")
COMMAND="./somelocal_script.sh -apikey ${HOOK_API_KEY} ${DYNAMIC_PARAMS}"

echo $COMMAND

