#!/bin/bash
set -e
source scripts/env.sh
source scripts/common.sh

bold "Set project"
gcloud config set project ${PROJECT_ID}

bold "Authorise GCP"
gcloud auth login --update-adc
