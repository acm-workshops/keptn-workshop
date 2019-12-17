#!/bin/bash

printf "Deploy carts service\nkeptn send event new-artifact --project=sockshop --service=carts --image=docker.io/jetzlstorfer/carts --tag=0.9.1\n"
keptn send event new-artifact --project=sockshop --service=carts --image=docker.io/jetzlstorfer/carts --tag=0.9.1

