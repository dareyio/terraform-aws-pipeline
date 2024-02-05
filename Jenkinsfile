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
                }
            }
        }

        
        stage('Lint Code') {
            steps {
                script {
                    echo 'Linting Terraform configurations...'
                    sh 'terraform validate'
                    echo 'Terraform configurations validated.'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'terraform init'
                        echo 'Running Terraform Plan'
                        sh 'terraform plan -out=tfplan'
                    }
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
        //             // Ask for manual confirmation before applying changes
                    input message: 'Do you want to apply changes?', ok: Yes
                    withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'terraform init'
                        echo 'Applying Terraform...'
                        sh 'terraform apply tfplan'
                    }
                }
            }
        }


        post {
        failure {
            
                echo 'Terraform Apply failed!'
                // Add notification or logging of detailed error messages here
                // For example, you can use the Email Extension plugin to send email notifications
            
        }
        always {
            stage('Cleanup') {
                steps {
                    
                        echo 'Performing cleanup...'
                        sh 'rm -rf tfplan' // Example cleanup command to remove plan file
                        echo 'Cleanup completed.'
                    
                }
            }
        }
    }
}
}

