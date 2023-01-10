# set up
.PHONY: $(shell sed -n -e '/^$$/ { n ; /^[^ .\#][^ ]*:/ { s/:.*$$// ; p ; } ; }' $(MAKEFILE_LIST))
namespace?=$$(whoami | tr '[:upper:]' '[:lower:]' | tr -d '.')

.DEFAULT_GOAL := help

##########################
# main scripts

help: ## This is help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

auth_gcp: ## To authenticate with Google Cloud, and set current project to one defined in config
	@scripts/$@.sh

project_create: ## OPTIONAL to create the Cloud Function Project in required location and attach the billing account
	@scripts/$@.sh

iam_create: ## OPTIONAL to create your Cloud Function IAM invoke user
	@scripts/$@.sh

function_create: ## To create your Cloud Function and give your IAM user invoke rights
	@scripts/$@.sh

schedule_create: ## To create your Cloud Schedule for your Cloud Function
	@scripts/$@.sh
