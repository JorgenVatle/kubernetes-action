#!/bin/sh -l

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

result="$(kubectl $1 2> error.log)"
status=$?

result="${result//'%'/'%25'}"
result="${result//$'\n'/'%0A'}"
result="${result//$'\r'/'%0D'}"
echo ::set-output name=result::"$result"
echo "$result"

error="$(cat error.log)"
error="${error//'%'/'%25'}"
error="${error//$'\n'/'%0A'}"
error="${error//$'\r'/'%0D'}"
echo ::set-output name=error::"$error"
echo "$error"

if [[ $status -eq 0 ]]; then exit 0; else exit 1; fi
