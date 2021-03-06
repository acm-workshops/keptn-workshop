#!/bin/bash -x

#If directory exists continue, otherwise exit
if [[ -d "unleash" ]]; then
    # The context for this script needs to be in examples/unleash-server
    keptn create project unleash --shipyard=./shipyard.yaml
    keptn onboard service unleash-db --project=unleash --chart=./unleash-db
    keptn onboard service unleash --project=unleash --chart=./unleash
    keptn send event new-artifact --project=unleash --service=unleash-db --image=postgres:10.4
    keptn send event new-artifact --project=unleash --service=unleash --image=docker.io/keptnexamples/unleash:1.0.0

    # Configure Keptn
    kubectl -n keptn create secret generic unleash --from-literal="UNLEASH_SERVER_URL=http://unleash.unleash-dev/api" --from-literal="UNLEASH_USER=keptn" --from-literal="UNLEASH_TOKEN=keptn"
    kubectl delete pod -l=run=remediation-service -n keptn

    # Adding the remediation is still needed
else 
    echo "The helmcharts for unleash are not present"
fi 

