#!/bin/bash

printf "Deploy database service\nkeptn send event new-artifact --project=sockshop --service=carts-db --image=mongo\n"
keptn send event new-artifact --project=sockshop --service=carts-db --image=mongo


