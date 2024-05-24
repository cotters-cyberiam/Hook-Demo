#!/bin/bash
#-------------------------------------------
# Script to create/start resources
#-------------------------------------------

# Variables
namespace=k8stestapi
deploy=$namespace-deploy.yml

# Create Namespace
echo "Creating Namespace: $namespace"
echo "   kubectl apply -f $namespace-namespace.yml"
echo "-------------------------------------------------"
kubectl apply -f $namespace-namespace.yml
echo ""

# Deploy Application / Start Application Resources"
echo "Start Application Resources"
echo "   kubectl apply -f $deploy -n $namespace"
echo "-------------------------------------------------"
kubectl apply -f $deploy -n $namespace
echo ""

# Verify Application Resources
echo "Show Application Resources"
echo "   kubectl get pods -n $namespace -o wide"
echo "-------------------------------------------------"
sleep 10
kubectl get pods -n $namespace -o wide

