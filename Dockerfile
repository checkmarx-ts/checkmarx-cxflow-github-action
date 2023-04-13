#Use CxFlow Base image
FROM satyam9889331154/githubaction123:scanIDGitAction
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
COPY 1.sh /app/1.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
RUN chmod +x /app/1.sh

ENTRYPOINT ["/app/entrypoint.sh","/app/1.sh"]
