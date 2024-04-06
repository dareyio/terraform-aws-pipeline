// pipeline {
  //  agent any

//pipeline {
  //  agent any

    //stages {
      //  stage('Checkout') {
          //  steps {
            //    script {
          //          checkout scm
           //     }
           // }
       // }

        //stage('Terraform Plan') {
          //  steps {
              //  script {
                  //  echo 'Executing Terraform Plan...'
                   // withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    //    sh 'terraform init'
                      //  sh 'terraform plan'
                  //  }
                    //echo 'Terraform Plan executed successfully.'
              //  }
           // }
       // }

       // stage('Terraform Apply') {
         //   when {
              //  expression { env.BRANCH_NAME == 'main' }
                //expression { currentBuild.rawBuild.getCause(hudson.model.Cause$UserIdCause) != null }
           // }
           // steps {
             //   script {
                    // Ask for manual confirmation before applying changes
                    //input message: 'Do you want to apply changes?', ok: 'Yes'
                  //  echo 'Executing Terraform Apply...'
                 //   withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        //sh 'terraform init'
                       // sh 'terraform apply tfplan'
                  //  }
                   // echo 'Terraform Apply executed successfully.'
               // }
           // }
       // }
   // }
//}
//pipeline {
   // agent any

   // environment {
     //   TF_CLI_ARGS = '-no-color'
   // }
//
   // stages {
     //   stage('Checkout') {
           // steps {
               // script {
                //    checkout scm
              //  }
        //    }
       // }
//
       // stage('Terraform Plan') {
           // steps {
              //  script {
                   // echo 'Executing Terraform Plan...'
                    //withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    //    sh 'terraform init'
                     //   sh 'terraform plan'
                   // }
                   // echo 'Terraform Plan executed successfully.'
               // }
           // }
       // }

        //stage('Terraform Apply') {
           // when {
              //  expression { env.BRANCH_NAME == 'main' }
                //expression { currentBuild.rawBuild.getCause(hudson.model.Cause$UserIdCause) != null }
           // }
           // steps {
                //script {
                    // Ask for manual confirmation before applying changes
                   // input message: 'Do you want to apply changes?', ok: 'Yes'
                  //  echo 'Executing Terraform Apply...'
                  //  withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
//sh 'terraform init'
                 //       sh 'terraform apply tfplan'
                  //  }
               //     echo 'Terraform Apply executed successfully.'
         //       }
         //   }
    //    }
   // }
//}

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

        stage('Terraform Lint') {
            steps {
                script {
                    echo 'Executing Terraform Lint...'
                    sh 'terraform init -input=false -no-color'
                    sh 'terraform validate'
                    echo 'Terraform Lint executed successfully.'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    echo 'Executing Terraform Plan...'
                    withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'terraform init -input=false -no-color'
                        sh 'terraform plan -input=false -no-color'
                    }
                    echo 'Terraform Plan executed successfully.'
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
                    echo 'Executing Terraform Apply...'
                    withCredentials([aws(credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'terraform init -input=false -no-color'
                        sh 'terraform apply tfplan -input=false -no-color'
                    }
                    echo 'Terraform Apply executed successfully.'
                }
            }
        }
    }
}