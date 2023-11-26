pipeline {
    agent any

    environment {
        TF_CLI_ARGS = '-no-color'
    }

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
                    // Ask for manual confirmation before applying changes
                    input message: 'Do you want to apply changes?', ok: 'Yes'
                    sh 'terraform apply tfplan'
                }
            }
        }
    }
}
