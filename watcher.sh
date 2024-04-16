#!/bin/bash          
NAMESPACE="sre"
DEPLOYMENT="swype-app"
RESTARTS=4
while true
do
  COUNT=$(kubectl get pods -n ${NAMESPACE} -l app=${DEPLOYMENT} -o jsonpath="{.items[0].status.containerStatuses[0].restartCount}")

  echo "Restarts: ${COUNT}"

  if (( COUNT > RESTARTS )); then
    kubectl scale --replicas=0 -n ${NAMESPACE} deployment/${DEPLOYMENT} 
    break
  fi

  sleep 60
done