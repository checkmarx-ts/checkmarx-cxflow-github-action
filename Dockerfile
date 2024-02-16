#Use CxFlow Base image
RUN ["hostname", "--all-fqdns"] && \
    echo "$HOSTNAME:$(getent ahostsv4 "$HOSTNAME" | head -n1 | cut -d' ' -f1)" >> /etc/hosts
RUN ip addr show || true
WORKDIR /app
CMD ["your", "application", "command"]

FROM checkmarx/cx-flow:1.6.44
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
