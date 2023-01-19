#!/bin/sh -l

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig

export KUBECONFIG=kubeconfig
export COMMAND="kubectl $*"
export RESULT

RESULT="$(sh -c "$COMMAND" 2>&1)"
exitCode=$?

result="$RESULT"
result="${result//'%'/'%25'}"
result="${result//$'\n'/'%0A'}"
result="${result//$'\r'/'%0D'}"

# Emit result as GitHub output
EOF="EOF-$RANDOM"
echo "result<<$EOF" >> $GITHUB_OUTPUT
echo $result >> $GITHUB_OUTPUT
echo "$EOF" >> $GITHUB_OUTPUT

echo "$result"

if [[ $exitCode -eq 0 ]]; then
  exit 0;
else
  cat ./.assets/error-summary-template.md | envsubst >> $GITHUB_STEP_SUMMARY
  exit 1;
fi
