#!/bin/bash
printf "\nOnboard the Database service with a direct deployment strategy (only one instance per Stage)\nkeptn onboard service carts-db --project=sockshop --chart=./carts-db --deployment-strategy=direct"
keptn onboard service carts-db --project=sockshop --chart=./carts-db --deployment-strategy=direct
