#!/bin/bash
set -e
source scripts/env.sh
source scripts/common.sh

bold "Create IAM user to invoke cloud function"
gcloud --project=${PROJECT_ID} iam service-accounts create ${IAM_ACCOUNT} --description="Used for invoking cloud function"
