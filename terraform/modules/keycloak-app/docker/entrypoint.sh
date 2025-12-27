#!/bin/bash
set -e

envsubst < /opt/keycloak/data/import/master-realm-terraform.json.template \
         > /opt/keycloak/data/import/master-realm-terraform.json

exec /opt/keycloak/bin/kc.sh "$@"
