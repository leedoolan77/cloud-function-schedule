# Cloud Function Schedule

This repository will guide you on where to develop & how to deploy a Cloud Function, and schedule it via the Cloud Scheduler.

## Develop Cloud Function

The Cloud Function is devloped in th e location *src/Cloud Function* and requires 2 files:

- main.py - This is the python code that will run your Cloud Function
- requirements.txt - This file includes all the additional modules your python code will need e.g. *google-cloud-pubsub==2.13.10*

## Environment Config

All Config is set in the file **config/${ENV}_env** where *ENV* is the name of the required environment, and is a system variable. Config items are described as below:


| Name | Description | Required |
| ----------- | ----------- | ----------- |
| PROJECT_ID | The project id of where the cloud function will be created e.g. *project-id-2345* | Yes |
| REGION | The region of where the cloud function will be created e.g. *europe-west2* | Yes |
| IAM_ACCOUNT | The IAM account name that will invoke the cloud function e.g. *cloud-invoker* | Yes |
| FUNCTION | The name of the required Cloud Function e.g. *dummy-cf* | Yes |
| FOLDER_ID | The folder id location of where the project is located e.g. *1234567890* | Optional, if project needs creating |
| BILLING_ACCOUNT_ID | The billing account id to be used for the project e.g. *12345-12345-12345* | Optional, if project needs creating |

## Deploy / Schedule

Script files have been created to help with the deploy, and should be run in the the order below (if required):

> Note: All build scripts in build run the *scripts/env.sh* script first to gather variables. This is currently hard coded to the **dev** environment, and should be changed as required.

**Before deploying ensure you have added the required config items for your environment as detailed above.**

1. `scripts/auth_gcp.sh` - To authenticate with Google Cloud, and set current project to one defined in config.
2. `scripts/project_create.sh` - **OPTIONAL** to create the Cloud Function Project in required location and attach the billing account.
3. `scripts/iam_create.sh` - **OPTIONAL** to create your Cloud Function IAM invoke user. 
4. `scripts/function_create.sh` - To create your Cloud Function and give your IAM user invoke rights.
    - **IMPORTANT NOTE 1** the Cloud Function will be created using default settings. Change as required
    - **IMPORTANT NOTE 2** the IAM user may need additional permissions to use other resources. Add as required.
5. `scripts/schedule_create.sh` - To create your Cloud Schedule for your Cloud Function.
    - **IMPORTANT NOTE 1** the Cloud Schedule will be created using default settings. Change as required