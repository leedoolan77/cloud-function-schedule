#!/bin/bash
set -e
source scripts/env.sh
source scripts/common.sh

SCHEDULE_NAME="Dummy_Schedule"
SCHEDULE_DESCR="Execute a cloud function"
SCHEDULE_CRON="0 10 * * *"

bold "Enable required services"
gcloud --project=${PROJECT_ID} services enable cloudscheduler.googleapis.com
sleep 5

bold "Create the schedule"
gcloud --project="${PROJECT_ID}" scheduler jobs create http "${SCHEDULE_NAME}" --location="${REGION}"  --description="${SCHEDULE_DESCR}" \
--schedule="${SCHEDULE_CRON}" --time-zone="Europe/London" \
--uri="https://${REGION}-${PROJECT_ID}.cloudfunctions.net/${FUNCTION}" --http-method="post" --headers="Content-Type=application/octet-stream,User-Agent=Google-Cloud-Scheduler" \
--oidc-service-account-email="${IAM_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" --oidc-token-audience="https://${REGION}-${PROJECT_ID}.cloudfunctions.net/${FUNCTION}" \
--max-retry-attempts="0" --max-retry-duration="0s" --min-backoff="5s" --max-backoff="1h" --max-doublings="5"
