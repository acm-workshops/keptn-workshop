#!/bin/bash
printf "Send carts v2 deployment a slow implementation of the carts service\n"
keptn send event new-artifact --project=sockshop --service=carts --image=docker.io/jetzlstorfer/carts --tag=0.9.2