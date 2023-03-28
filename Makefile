.ONESHELL:
SHELL := /bin/zsh
.SHELLFLAGS += -e
MAKEFLAGS += --warn-undefined-variables
include .env
# export $(shell sed 's/=.*//' $(ENV_FILE))

ce-reset: ce-jr-delete ce-br-delete

push-and-build: gh-push ce-build-run

auth-target:
	ibmcloud login -a https://cloud.ibm.com -r us-south -g CDE -q
	ibmcloud ce project target --name ${PROJECT_NAME}

gh-push:
	git add . && git commit -m "Building new container image" && git push

ce-build-run: ce-br-delete ce-build

ce-build:
	echo "Building container image from source."
	
	ibmcloud ce buildrun submit --name ${BUILD_NAME}-br-$$(hostname -s) --build ${BUILD_NAME}

	ibmcloud ce buildrun logs -f -n ${BUILD_NAME}-br-$$(hostname -s)
	
ce-submit-job:

	echo "Submitting job run to Code Engine"
	
	ibmcloud ce jobrun submit --name ${JOB_NAME}-jr-$$(hostname -s)   --job ${JOB_NAME} 

	ibmcloud ce jobrun logs -f -n ${JOB_NAME}-jr-$$(hostname -s) 

ce-jr-delete:

	echo "Deleting all jobruns for ${JOB_NAME}"
	
	ibmcloud ce jobrun delete --job ${JOB_NAME} --ignore-not-found --force

ce-br-delete:
	
	echo "Deleting all buildruns for ${BUILD_NAME}"
	
	ibmcloud ce buildrun delete --build ${BUILD_NAME} --ignore-not-found --force
