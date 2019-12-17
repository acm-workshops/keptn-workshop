#!/bin/bash

printf "Add resource Service Indicators and Service Level Objectives to Staging\n"
keptn add-resource --project=sockshop --service=carts --stage=staging --resource=service-indicators.yaml --resourceUri=service-indicators.yaml
keptn add-resource --project=sockshop --service=carts --stage=staging --resource=service-objectives-dynatrace-only.yaml --resourceUri=service-objectives.yaml