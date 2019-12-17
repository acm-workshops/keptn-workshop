#!/bin/bash
echo "Deployment of a slow implementation of the carts service"
keptn send event new-artifact --project=sockshop --service=carts --image=docker.io/jetzlstorfer/carts --tag=0.9.3