pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    checkout scm
                    sh 'ls -la'
                    sh 'pwd'
                }
            }
        }

        stage('Terraform Plan') {
            when {
                expression { env.BRANCH_NAME != 'main' }
            }
            steps {
                script {
                    sh 'terraform --version'
                    sh 'terraform init -backend-config="backend.tfvars"'
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { env.BRANCH_NAME == 'main' }
                expression { currentBuild.rawBuild.getCause(hudson.model.Cause$UserIdCause) != null }
            }
            steps {
                script {
                    input 'Do you want to apply changes?'
                    sh 'terraform apply tfplan'
                }
            }
        }
    }
}
