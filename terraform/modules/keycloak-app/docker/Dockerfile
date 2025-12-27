FROM quay.io/keycloak/keycloak:26.0

COPY --chown=1000:0 master-realm-terraform.json.template \
     /opt/keycloak/data/import/master-realm-terraform.json.template

COPY --chown=1000:0 master-realm-terraform.json \
     /opt/keycloak/data/import/master-realm-terraform.json

ENTRYPOINT ["/opt/keycloak/bin/entrypoint.sh"]
