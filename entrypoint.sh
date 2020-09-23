#!/bin/sh
printenv
java -jar /app/cx-flow.jar --spring.config.location=/app/application.yml --scan --cx-team="${TEAM}" --cx-project="${PROJECT}" --app="${APP}" --f=. ${CXFLOW_PARAMS}
