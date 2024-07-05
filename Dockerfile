RUN echo "Using base image 1 : ${CX_FLOW_ENABLED_VULNERABILITY_SCANNERS}"
RUN echo "Using base image 2 : ${{ inputs.scanners }}"
FROM satyam9889331154/githubaction123:democxflowfinal1
#Copy script to import certs into Java cacerts keystore
COPY scripts/keytool-import-certs.sh /app/keytool-import-certs.sh
#Make it executable
RUN chmod +x /app/keytool-import-certs.sh
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
