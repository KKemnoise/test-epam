pipeline {
    parameters {
      choice(name: 'build_env', choices: ['dev','qa','uat','prod'], description: 'Environment')
      choice(name: 'TERRAFORM_ACTION', choices: ['plan','apply','destroy'], description: 'Terraform Action')

    }
    environment {
        SERVICE_NAME="aks-nodejs-bg-helloworld"
        TAG_EXISTS = null
        APP_GIT_REPO = "gitlab.com/daedatechnologies/aks-nodejs-bg-helloworld.git"
        registry = "daeda.azurecr.io"
        project_name = "aks-nodejs-bg-helloworld"
        TERRAFORM_BACKEND_KEY = "aks-nodejs-bg-helloworld/${ENVIRONMENT}.tfstate"
        S3_BUCKET = "daedatechnologies-terraform-state"
        S3_REGION = "us-east-1"
        TERRAFORM_FILE_PATH = 'terraform/main.tf'
        TERRAFORM_BASE_DIR = 'terraform/'
    }
    agent any
    stages {         
		  stage('Build Cluster') {
                  when {
                        not { environment name: 'TERRAFORM_ACTION', value: 'destroy' }
                 }
                 steps {
                        sh 'echo "#######################################"'
                        terraformS3Backend()
                        buildCluster()
                        }
                 }
       }
    }
}

