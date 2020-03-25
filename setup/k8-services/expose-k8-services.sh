#!/bin/bash -x

printf "\nSkip Login in K8 Dashboard \n"
kubectl apply -f skip-login-in-k8-dashboard.yaml

printf "\nExpose Kubernetes API, Grafana & Dashboard \n"
export PUBLIC_IP=$(curl -s ifconfig.me) 
PUBLIC_IP_AS_DOM=$(echo $PUBLIC_IP | sed 's~\.~-~g')
export DOMAIN="${PUBLIC_IP_AS_DOM}.nip.io"

cat k8-svc-ingress.yaml | \
  sed 's~domain.placeholder~'"$DOMAIN"'~' > ./gen/k8-svc-ingress.yaml

# Deploy ingress with rules to domains and ingress-gateway. Create secret and certificate
kubectl apply -f gen/k8-svc-ingress.yaml