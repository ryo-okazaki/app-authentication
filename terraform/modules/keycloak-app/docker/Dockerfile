FROM quay.io/keycloak/keycloak:26.0

COPY --chmod=0755 setup-terraform-client.sh /opt/keycloak/bin/

COPY --chmod=0755 entrypoint.sh /opt/keycloak/bin/

ENTRYPOINT ["/opt/keycloak/bin/entrypoint.sh"]
