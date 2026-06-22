#Use CxFlow Base image
FROM checkmarx/cx-flow@sha256:feedcf239a910df30ac2dcbe580bfa05eb916d70e021bb62ea8d4ff72d8add77
#Copy script to import certs into Java cacerts keystore
COPY scripts/keytool-import-certs.sh /app/keytool-import-certs.sh
#Make it executable
RUN chmod +x /app/keytool-import-certs.sh
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
