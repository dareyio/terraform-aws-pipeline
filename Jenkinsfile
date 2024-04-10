pipeline {
    agent {
        kubernetes {
            label 'my-terraform-agent'
            defaultContainer 'jnlp'
            yaml """
            apiVersion: v1
            kind: Pod
            metadata:
              namespace: tools
            spec:
              containers:
              - name: terraform
                image: hashicorp/terraform:latest
                command:
                - cat
                tty: true
            """
        }
    }

    environment {
        TF_CLI_ARGS = '-no-color'
    }

    stages {
        stage("Clean Workspace") {
            steps {
                dir("${WORKSPACE}") {
                    deleteDir()
                }
            }
        }

        stage('Checkout') {
            steps {
                script {
                    checkout scm
                }
            }
        }
        stage('Terraform init'){
            steps{
                container('terraform') {
                    script{
                        sh 'terraform init'
                    }
            }
        }
        }
 
        stage('Terraform validate'){
            steps{
                container('terraform') {
                    script{
                        sh 'terraform validate'
                    }
            }
        }
        }

        stage('Terraform Plan') {
            steps {
                container('terraform') {
                    script {
                        echo "Starting Terraform Plan"
                        withCredentials([aws(credentialsId: 'AWS_CREDENTIALS', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                            sh 'terraform plan -out=tfplan'
                            echo "Terraform plan executed successfully!!"
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                allOf {
                    // expression { env.BRANCH_NAME == 'main' }
                    expression { currentBuild.rawBuild.getCause(hudson.model.Cause$UserIdCause) != null }
                }
            }
            steps {
                container('terraform') {
                    script {
                        // Ask for manual confirmation before applying changes
                        input message: 'Do you want to apply changes?', ok: 'Yes'
                        withCredentials([aws(credentialsId: 'AWS_CREDENTIALS', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                            sh 'terraform apply  -out=tfplan'
                        }
                    }
                }
            }
        }
    }
}
