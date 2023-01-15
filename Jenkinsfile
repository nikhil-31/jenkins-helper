pipeline {
    agent any
    tools {
        // maven 'Maven'
    }
    parameters {
        string(name: 'VERSION', defaultValue: '', description: 'version to deploy on Prod')
        choice(name: 'VERSION', choices: ['1.1.0', '1.2.0', '1.3.0'] , description: '')
        booleanParam(name: 'executeTest', defaultValue: true, 'description': '')
    }
    environment {
        NEW_VERSION = '1.3.0'
        SERVER_CREDENTIALS = credentials('dockerhub')
    }
    stages {
        stage("Build Image") {
            steps {
                echo "Building the damn image"
                sh "${SERVER_CREDENTIALS}"
            }
        }
        stage("Test image") {
            when {
                expressions {
                    env.BRANCH_NAME == 'dev' || env.BRANCH_NAME == 'master'
                    params.executeTest == true
                }
            }
            steps {
                echo "Testing the stupid image "
                echo "Building version ${NEW_VERSION}" 
            }
        }
        stage("deploy") {
            steps {
                echo "Deploying the fake image"
                withCredentials(usernamePassword(credentaials: 'dockerhub'), usernameVariable: USER, passwordVariable: PWD) {
                    sh "some script ${USER} , password ${PWD}"
                }
                echo "Deploying version ${params.VERSION}"
            }
        }
    }
    post {
        always {
        }
        failure {
        }
    }
  }  
}