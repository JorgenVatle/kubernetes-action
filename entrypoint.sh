#!/bin/sh -l

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

result="$(kubectl $1 2>&1)"
status=$?

result="${result//'%'/'%25'}"
result="${result//$'\n'/'%0A'}"
result="${result//$'\r'/'%0D'}"

# Emit result as GitHub output
echo 'result<<EOF' >> $GITHUB_OUTPUT
echo $result >> $GITHUB_OUTPUT
echo 'EOF' >> $GITHUB_OUTPUT

echo "$result"

if [[ $status -eq 0 ]]; then exit 0; else exit 1; fi
