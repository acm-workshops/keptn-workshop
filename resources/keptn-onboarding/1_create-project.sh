#!/bin/bash

printf "Create Project: keptn create project sockshop --shipyard=./shipyard.yaml\n"
printf "Shipyard File:\n"
cat shipyard.yaml
printf "\n-------"
keptn create project sockshop --shipyard=./shipyard.yaml