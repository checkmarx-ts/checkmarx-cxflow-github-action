#Use CxFlow Base image
FROM satyam9889331154/githubaction1234:satyamreleasetry2
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
