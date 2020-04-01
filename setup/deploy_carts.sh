#!/bin/bash -x

#If directory exists continue, otherwise exit
if [[ -d "carts" ]]; then
    # The context for this script needs to be in examples/onboarding-carts
    keptn create project sockshop --shipyard=./shipyard.yaml
    keptn onboard service carts --project=sockshop --chart=./carts
    keptn add-resource --project=sockshop --stage=dev --service=carts --resource=jmeter/basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx
    keptn add-resource --project=sockshop --stage=staging --service=carts --resource=jmeter/load.jmx --resourceUri=jmeter/load.jmx

    keptn onboard service carts-db --project=sockshop --chart=./carts-db --deployment-strategy=direct
    keptn send event new-artifact --project=sockshop --service=carts-db --image=docker.io/mongo --tag=4.2.2
    keptn send event new-artifact --project=sockshop --service=carts --image=docker.io/keptnexamples/carts --tag=0.10.1
else 
    echo "The helmcharts for carts are not present"
fi 

