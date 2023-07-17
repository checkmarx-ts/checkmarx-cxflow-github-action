#Use CxFlow Base image
FROM checkmarx/cx-flow
#Copy script to import certs into Java cacerts keystore
COPY scripts/keytool-import-certs.sh /app/keytool-import-certs.sh

COPY certificate.crt /app/checkmarx2.crt
docker ps -a
#COPY /actions-runner/_work/IAM_Asset/IAM_Asset/certificate/checkmarx.crt /app/checkmarx1.crt

#Giving Permission to file
RUN chmod 500 /app/keytool-import-certs.sh

#RUN chmod 500 /app/checkmarx1.crt
RUN chmod 500 /app/checkmarx2.crt

#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
