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
            steps {
                script {
                    withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        echo "AWS_ACCESS_KEY_ID: ${env.AWS_ACCESS_KEY_ID}"
                        echo "AWS_SECRET_ACCESS_KEY: ${env.AWS_SECRET_ACCESS_KEY}"

                        sh 'terraform init'
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        // stage('Terraform Apply') {
        //     when {
        //         expression { env.BRANCH_NAME == 'main' }
        //         expression { currentBuild.rawBuild.getCause(hudson.model.Cause$UserIdCause) != null }
        //     }
        //     steps {
        //         script {
        // //             // Ask for manual confirmation before applying changes
        //             input message: 'Do you want to apply changes? Please review the Terraform plan and confirm.', ok: 'Yes'
        //             withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
        //                 echo "AWS_ACCESS_KEY_ID: ${env.AWS_ACCESS_KEY_ID}"
        //                 echo "AWS_SECRET_ACCESS_KEY: ${env.AWS_SECRET_ACCESS_KEY}"

        //                 sh 'terraform init'
        //                 sh 'terraform plan -out=tfplan'
        //             }
        //         }
        //     }
        // }
    }
}
