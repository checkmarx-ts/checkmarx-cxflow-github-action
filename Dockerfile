#Use CxFlow Base image
#FROM checkmarx/cx-flow
FROM satyam9889331154/githubaction123:dilesizeissue
#Copy script to import certs into Java cacerts keystore
COPY scripts/keytool-import-certs.sh /app/keytool-import-certs.sh
#Giving Permission to file
RUN chmod 500 /app/keytool-import-certs.sh
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
