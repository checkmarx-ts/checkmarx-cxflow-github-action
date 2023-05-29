#!/bin/sh
java ${JAVA_OPTS} -jar /app/cx-flow.jar --SHA=$GITHUB_SHA --spring.profiles.active="${CX_FLOW_ENABLED_VULNERABILITY_SCANNERS}" --scan --github.api-url="${GITHUB_API_URL}/repos/" --cx-team="${TEAM}" --cx-project="${PROJECT}" --app="${APP}" --jira.url="${JIRA_URL}" --jira.username="${JIRA_USERNAME}" --jira.token="${JIRA_TOKEN}" --jira.project="${JIRA_PROJECT}" --jira.issue-type="${JIRA_ISSUE_TYPE}" --jira.open-transition="${JIRA_OPEN_TRANSITION}" --jira.close-transition="${JIRA_CLOSE_TRANSITION}" --jira.open-status="${JIRA_OPEN_STATUS}"  --f=. ${CXFLOW_PARAMS} 2> scanid$GITHUB_SHA.txt
scanID=$(grep 'cxflowscanidextraction' scanid$GITHUB_SHA.txt | sed 's/.*cxflowscanidextractiongithubaction \(.*\)endofstatementscanidaction/\1/')
echo "cxflowscanid=$scanID" >> $GITHUB_OUTPUT
rm scanid$GITHUB_SHA.txt
EXIT_CODE=$(grep 'Finished with exit code:' cx-flow.log | tail -1 |sed 's/.*: //')
if [ $EXIT_CODE != 0 ]
then
        echo 'Exit code is Non Zero so breaking pipeline.'
        exit 1
else
        echo 'CxFlow Github Action Run Successfully.'
        exit 0
fi
