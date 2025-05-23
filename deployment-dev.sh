#!/bin/bash

docker compose -f docker-compose.yml build --no-cache
docker compose up -d

# Step 1: Build Docker images for all apps
eval $(minikube -p minikube docker-env)

docker-compose build

# Step 2: Apply Kubernetes deployment and service files
kubectl apply -f CustomerService/customerservice-deployment.yml
kubectl apply -f ApiGateway/apigatewayservice-deployment.yml
kubectl apply -f InvoiceGenerationService/invoicegeneration-deployment.yml
kubectl apply -f OrderInventoryService/orderinventoryservice-deployment.yml
kubectl apply -f OrderService/orderservice-deployment.yml
kubectl apply -f PaymentService/paymentservice-deployment.yml
kubectl apply -f InvoiceMessageListenerService/invoicemessagelistenerservice-deployment.yml

echo "Applications have been deployed to Kubernetes!"