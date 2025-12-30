#!/bin/bash
ENV="${1:-dev}"

BASTION_ID=$(aws ssm get-parameter --name "/${ENV}/network/bastion_instance_id" --query "Parameter.Value" --output text)
RDS_ENDPOINT=""

echo "Starting tunnel to RDS via Bastion..."
echo "Connect with: psql -h localhost -p 5432 -U keycloak -d keycloak"

aws ssm start-session \
  --target "$BASTION_ID" \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters "{\"host\":[\"${RDS_ENDPOINT}\"],\"portNumber\":[\"5432\"],\"localPortNumber\":[\"5432\"]}"
