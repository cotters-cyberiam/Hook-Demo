#!/bin/bash
#---------------------------------------------
# Script to delete resources
#---------------------------------------------

# Variables
namespace=k8stestapi
deploy=$namespace-deploy.yml

# Delete Resources
echo "Deleting Application Resources"
echo "  kubectl delete -f $deploy -n $namespace"
echo "----------------------------------------------------------"
kubectl delete -f $deploy -n $namespace
echo ""

echo "Deleting Namespace: $namespace"
echo "  kubectl delete -f $namespace-namespace.yml"
echo "----------------------------------------------------------"
kubectl delete -f $namespace-namespace.yml
