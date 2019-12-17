#!/bin/bash
printf "\nAdd functional Test to Development and Staging Stage\n"
keptn add-resource --project=sockshop --service=carts --stage=dev --resource=jmeter/basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx
keptn add-resource --project=sockshop --service=carts --stage=staging --resource=jmeter/basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx
printf "\nAdd basic LoadTest (Integrations-test) to Development and Staging Stage\n"
keptn add-resource --project=sockshop --service=carts --stage=dev --resource=jmeter/load.jmx --resourceUri=jmeter/load.jmx
keptn add-resource --project=sockshop --service=carts --stage=staging --resource=jmeter/load.jmx --resourceUri=jmeter/load.jmx