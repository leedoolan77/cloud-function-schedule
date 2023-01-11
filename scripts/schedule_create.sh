#!/bin/bash
#set -e
source scripts/env.sh
source scripts/common.sh

SCHEDULE_NAME="Dummy_Schedule"
SCHEDULE_DESCR="Execute a cloud function"
SCHEDULE_CRON="0 10 * * *"

bold "Enable required services"
gcloud --project=${PROJECT_ID} services enable cloudscheduler.googleapis.com
sleep 5

bold "Create the schedules"
gcloud --project="${PROJECT_ID}" scheduler jobs create http "${SCHEDULE_NAME}_1" --location="${REGION}"  --description="${SCHEDULE_DESCR}" \
--schedule="${SCHEDULE_CRON}" --time-zone="Europe/London" \
--uri="https://${REGION}-${PROJECT_ID}.cloudfunctions.net/${FUNCTION}?message=Dummy_Schedule_1" --http-method="post" \
--oidc-service-account-email="${IAM_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" --oidc-token-audience="https://${REGION}-${PROJECT_ID}.cloudfunctions.net/${FUNCTION}" \
--max-retry-attempts="0" --max-retry-duration="0s" --min-backoff="5s" --max-backoff="1h" --max-doublings="5"

gcloud --project="${PROJECT_ID}" scheduler jobs create http "${SCHEDULE_NAME}_2" --location="${REGION}"  --description="${SCHEDULE_DESCR}" \
--schedule="${SCHEDULE_CRON}" --time-zone="Europe/London" \
--uri="https://${REGION}-${PROJECT_ID}.cloudfunctions.net/${FUNCTION}?message=Dummy_Schedule_2" --http-method="post" \
--oidc-service-account-email="${IAM_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" --oidc-token-audience="https://${REGION}-${PROJECT_ID}.cloudfunctions.net/${FUNCTION}" \
--max-retry-attempts="0" --max-retry-duration="0s" --min-backoff="5s" --max-backoff="1h" --max-doublings="5"