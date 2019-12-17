#!/bin/bash
source ./utils.sh

# API documentation
# https://www.dynatrace.com/support/help/extend-dynatrace/dynatrace-api/

DT_TENANT=$1
DT_API_TOKEN=$2
KEPTN_DNS=$3
BASTION_IP=$(curl https://ipinfo.io/ip)
USER=$(whoami)


# Import Request Attributes
import_requestAttributes(){
  DESTINATION="https://$DT_TENANT/api/config/v1/service/requestAttributes/?api-token=$DT_API_TOKEN"
  for json in ./dynatrace_configuration/requestAttribute*.json
  do
    response=$(curl -X POST --silent -H 'Content-Type: application/json' -H 'cache-control: no-cache' -d @$json $DESTINATION)
    #TODO Do validation if request attribute is there.
    if [[ $response == *"error"* ]]; then
      echo "Error importing a RequestAttribute: $json message: $response"    
    fi
  done
}

# Import Dashboards
import_dashboards(){
  DESTINATION="https://$DT_TENANT/api/config/v1/dashboards/?api-token=$DT_API_TOKEN"
  for json in ./dynatrace_configuration/dashboard*.json
  do
    # reads, replaces and writes in a .gen file.
    sed -e "s/KEPTN_DNS/$KEPTN_DNS/g" <$json > $json.gen
    sed -i "s/BASTION_IP/$BASTION_IP/g" $json.gen
    sed -i "s/USER/$USER/g" $json.gen
    response=$(curl -X POST -H 'Content-Type: application/json' -H 'cache-control: no-cache' -d @$json.gen $DESTINATION)
    if [[ $response == *"error"* ]]; then
      echo "Error importing the Dashboard: $json.gen message: $response"    
    fi
  done
}


import_requestAttributes
import_dashboards