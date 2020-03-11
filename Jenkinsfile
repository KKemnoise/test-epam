pipeline {
    parameters {
      choice(name: 'build_env', choices: ['dev','qa','uat','prod'], description: 'Environment')
      choice(name: 'TERRAFORM_ACTION', choices: ['plan','apply','destroy'], description: 'Terraform Action')

    }
    environment {
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

