#Use CxFlow Base image
FROM checkmarx/cx-flow
#Copy script to import certs into Java cacerts keystore
DOCKER_BUILDKIT=1
COPY --chmod=500 scripts/keytool-import-certs.sh /app/keytool-import-certs.sh
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
