#Use CxFlow Base image
FROM checkmarxts/cxflow:github
#Apply any updates
RUN apk update && apk upgrade
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
COPY application.yml /app/application.yml
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]