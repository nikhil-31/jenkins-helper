pipeline {
    agent any

    stages {
        stage("Build Image") {
            agent any
            steps {
                echo "Building the damn image"
            }
        }
        stage("Test image") {
            agent any
            steps {
                script {
                    sh "echo "Testing the stupid image" "
                }
            }
        }
        stage("deploy") {
            agent any
            steps {
                echo "Deploying the fake image"
            }
        }
    }
}