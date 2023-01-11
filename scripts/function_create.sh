#!/bin/bash
set -e
source scripts/env.sh
source scripts/common.sh

bold "Enable required services"
gcloud --project=${PROJECT_ID} services enable cloudfunctions.googleapis.com
gcloud --project=${PROJECT_ID} services enable cloudbuild.googleapis.com
sleep 5

bold "Create the function & give the IAM user invoke access"
gcloud --project=${PROJECT_ID} functions deploy ${FUNCTION} \
--trigger-http --entry-point process --region ${REGION}  \
--service-account ${IAM_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com \
--set-env-vars TOPIC_PROJECT_ID=${PROJECT_ID} \
--memory 128MB --timeout 60s --max-instances 5 \
--runtime python38 --source "src/Cloud Function" --quiet

gcloud --project=${PROJECT_ID} functions add-iam-policy-binding ${FUNCTION} \
--region ${REGION} --member serviceAccount:${IAM_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com \
--role roles/cloudfunctions.invoker