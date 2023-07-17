#!/bin/sh
docker ps -a
ls -la
# import custom certificates into java cacerts keystore
if [ -n "$EXTRA_CERTIFICATES" ]
then
        echo "Importing custom certificates in $EXTRA_CERTIFICATES subdirectory to '$JVMKEYTOOL_PATH'"

certs_dir=/github/workspace/$EXTRA_CERTIFICATES
jvm_keystore=$JVMKEYTOOL_PATH
count=1
for cert in $certs_dir/*.crt
do
  echo "importing cert $cert"
  keytool -trustcacerts -importcert \
    -alias "checkmarx${count}" \
    -file "$cert" \
    -keystore "$jvm_keystore" \
    -storepass 'changeit' -noprompt

  # increment count
  ((count++))
done
fi

java ${JAVA_OPTS} -jar /app/cx-flow.jar --SHA=$GITHUB_SHA --spring.profiles.active="${CX_FLOW_ENABLED_VULNERABILITY_SCANNERS}" --scan --github.api-url="${GITHUB_API_URL}/repos/" --cx-team="${TEAM}" --cx-project="${PROJECT}" --app="${APP}" --jira.url="${JIRA_URL}" --jira.username="${JIRA_USERNAME}" --jira.token="${JIRA_TOKEN}" --jira.project="${JIRA_PROJECT}" --jira.issue-type="${JIRA_ISSUE_TYPE}" --jira.open-transition="${JIRA_OPEN_TRANSITION}" --jira.close-transition="${JIRA_CLOSE_TRANSITION}" --jira.open-status="${JIRA_OPEN_STATUS}" --jira.closed-status="${JIRA_CLOSED_STATUS}" --f=. ${CXFLOW_PARAMS} 2> scanid$GITHUB_SHA.txt
JAVA_RETURN_STATUS=$(echo $?) 
scanID=$(grep 'cxflowscanidextraction' scanid$GITHUB_SHA.txt | sed 's/.*cxflowscanidextractiongithubaction \(.*\)endofstatementscanidaction/\1/')
echo "cxflowscanid=$scanID" >> $GITHUB_OUTPUT
rm scanid$GITHUB_SHA.txt
EXIT_CODE=$(grep 'Finished with exit code:' cx-flow.log | tail -1 |sed 's/.*: //')
if [ -z "$EXIT_CODE" ]
then
        exit $JAVA_RETURN_STATUS
else
        exit $EXIT_CODE
fi
