pipeline {
    agent any

    stages {
        stage('Run Shell Command') {
            steps {
            // Print some debugging information
            echo 'Current workspace: ' + pwd()
            echo 'Contents of the workspace: '
            sh 'ls -la'

            // Run the original shell command
            sh 'echo "Hello, Jenkins!"'
            }
        }
    }
}
