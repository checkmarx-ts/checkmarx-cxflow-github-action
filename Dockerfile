ARG CXFLOW_VERSION=default_value

# Set CXFLOW_VERSION as an environment variable
ENV CXFLOW_VERSION=$CXFLOW_VERSION
#Use CxFlow Base image
FROM itskedar/mycxflow:${CXFLOW_VERSION}
#Copy script to import certs into Java cacerts keystore
COPY scripts/keytool-import-certs.sh /app/keytool-import-certs.sh
#Make it executable
RUN chmod +x /app/keytool-import-certs.sh
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
