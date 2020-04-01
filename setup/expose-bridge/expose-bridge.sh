#!/bin/bash
if [ $# -eq 1 ]; then
    # Read JSON and set it in the CREDS variable 
    DOMAIN=$1
    echo $DOMAIN
else
    echo "No Domain has been passed, getting it from keptn-domain"
    DOMAIN=$(kubectl get cm -n keptn keptn-domain -ojsonpath={.data.app_domain})
fi

echo "About to create a VirtualService to the Keptn Bridge service"
cat ./manifests/bridge.yaml | \
  sed 's~domain.placeholder~'"$DOMAIN"'~' > ./manifests/gen/bridge.yaml

kubectl apply -f ./manifests/gen/bridge.yaml

echo "Bridge URL: https://bridge.keptn.$DOMAIN"
