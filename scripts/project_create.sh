#!/bin/bash
set -e
source scripts/env.sh
source scripts/common.sh

bold "Create project and attach billing account"
gcloud projects create ${PROJECT_ID} --folder=${FOLDER_ID} --name=${PROJECT_ID}
gcloud alpha billing projects link ${PROJECT_ID} --billing-account ${BILLING_ACCOUNT_ID}
