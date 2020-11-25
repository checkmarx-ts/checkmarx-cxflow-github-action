#Use CxFlow Base image
FROM checkmarx/cx-flow
#Apply any updates
RUN apk update && apk upgrade
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
COPY application.yml /app/application.yml
COPY application-sast.yml /app/application-sast.yml
COPY application-sca.yml /app/application-sca.yml
COPY application-cxgo.yml /app/application-cxgo.yml
COPY application-ast.yml /app/application-ast.yml
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]