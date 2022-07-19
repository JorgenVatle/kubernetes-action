#!/bin/sh -l

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

result="$(kubectl $1 2> error.log)"
status=$?

echo "::set-output name=result::$result"
echo "$result"

echo "::set-output name=error::$(cat error.log)"
echo "$error"

if [[ $status -eq 0 ]]; then exit 0; else exit 1; fi
