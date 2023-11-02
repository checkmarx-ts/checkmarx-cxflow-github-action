#Use CxFlow Base image
FROM satyam9889331154/githubaction123:imageissue
#Copy script to import certs into Java cacerts keystore
COPY scripts/keytool-import-certs.sh /app/keytool-import-certs.sh
ENV JVM_OPTS="-Xms4096m -Xmx8192m -XX:MaxRAMPercentage=75.0"
COPY certificate.crt /app/certificate.crt
RUN chmod +x /app/certificate.crt

#Make it executable
RUN chmod +x /app/keytool-import-certs.sh
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
