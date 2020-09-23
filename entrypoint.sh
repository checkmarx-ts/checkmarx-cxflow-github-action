#!/bin/sh
java -jar /app/cx-flow.jar --spring.config.location=/app/application.yml --scan --cx-team="${TEAM}" --cx-project="${PROJECT}" --github.api-url="${GITHUB_API_URL}/repos/" --app="${APP}" --f=. ${CXFLOW_PARAMS}
