pipeline {
    agent any

    stages {
        stage("Build Image") {
            agent any
            steps {
                echo "Build Image"
            }
        }
        stage("Test image") {
            agent any
            steps {
                script {
                    sh "echo "Test image""
                }
            }
        }
        stage("deploy image") {
            agent any
            steps {
                echo "Deploy image"
            }
        }
    }
}