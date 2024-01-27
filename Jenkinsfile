pipeline {
    agent any

    environment {
        TF_CLI_ARGS = '-no-color'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    echo "Checking out the repository..."
                    checkout scm
                    echo "Repository checkout completed."
                }
            }
        }

        stage('Lint Code'){
            steps {
                script {
                    echo "Validating Terraform configurations..."
                    sh "terraform validate"
                    echo "Terraform validation complete"
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        echo "Initializing Terraform..."
                        sh 'terraform init'
                        echo "Terraform initialization completed."

                        echo "Running Terraform plan..."
                        sh 'terraform plan -out=tfplan'
                        echo "Terraform plan completed."
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
                    echo "Manual confirmation required before applying changes..."
                    input message: 'Do you want to apply changes?', ok: 'Yes'
                    withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                         
                    echo "Initializing Terraform for apply..."
                    sh 'terraform init'
                    echo "Terraform initialization for apply completed."

                
                // Error handling with try-catch and email notification 
                      try {
                        echo "Applying Terraform changes..."
                        sh 'terraform apply tfplan'
                        echo "Terraform apply completed."
                    }
                    catch(Exception e) {
                        echo "Error: Terraform apply failed. Sending notification..."

                        // Sending email notification using emailext plugin if there is an error durring Terrafrom apply stage
                        emailext subject: "Pipeline Failure: ${currentBuild.fullDisplayName}",
                                  body: "Terraform apply failed: ${e.message}",
                                  to: 'a.anene98@gmail.com',
                                  mimeType: 'text/plain'
                        
                        currentBuild.result = 'FAILURE'
                        error("Terraform apply failed: ${e.message}")
                    }
                }
            }

        stage('Cleanup') {
            steps {
                script {
                    echo "Cleaning up temporary files and state..."
                    sh 'rm -rf tfplan' // Remove the Terraform plan file
                    echo "Cleanup completed."
                }
            }
        }
    }

    post {
        always {
            echo "Post build: This will always run, regardless of success or failure of previous stages."
            cleanWs()
        }

        success {
            echo "Post-build: This will only run if all stages are successful."
        }

        failure {
            echo "Post-build: This will only run if there is a failure in any of the stages."
            
            // Additional email notification for overall pipeline failure
            emailext subject: "Pipeline Failure: ${currentBuild.fullDisplayName}",
                      body: "One or more stages in the pipeline failed. Check the Jenkins console for details.",
                      to: 'a.anene98@gmail.com',
                      mimeType: 'text/plain'
        }
    }
   }
 }
}
}

