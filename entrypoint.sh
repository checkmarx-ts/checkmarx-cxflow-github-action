#!/bin/sh
java ${JAVA_OPTS} -jar /app/cx-flow.jar --SHA=$GITHUB_SHA --spring.profiles.active="${CX_FLOW_ENABLED_VULNERABILITY_SCANNERS}" --scan --github.api-url="${GITHUB_API_URL}/repos/" --cx-team="${TEAM}" --cx-project="${PROJECT}" --app="${APP}" --jira.url="${JIRA_URL}" --jira.username="${JIRA_USERNAME}" --jira.token="${JIRA_TOKEN}" --jira.project="${JIRA_PROJECT}" --jira.issue-type="${JIRA_ISSUE_TYPE}" --jira.open-transition="${JIRA_OPEN_TRANSITION}" --jira.close-transition="${JIRA_CLOSE_TRANSITION}" --jira.open-status="${JIRA_OPEN_STATUS}" --jira.closed-status="${JIRA_CLOSED_STATUS}" --f=. ${CXFLOW_PARAMS}

scanID=$(grep ':&:&:&:::' cx-flow.log | tr -d ':&:&:&::: ')

echo "cxflowscanid=$scanID" >> $GITHUB_OUTPUT

