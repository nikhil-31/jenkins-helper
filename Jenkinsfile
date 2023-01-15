pipeline {
    agent any
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
        
        stage("init") {
            steps {
                script {
                    gv = load "echo.groovy"
                }
            }
        }

        stage("Build Image") {
            steps {
                echo "Building the damn image"
                sh "${SERVER_CREDENTIALS}"
                script {
                    gv.build_app()
                }
            }
        }

        stage("Test image") {
            when {
                expression {
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
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh "sudo docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh 'sudo docker push nikhilsuper/django-polls:latest'
                }
                echo "Deploying version ${params.VERSION}"
            }
        }

        stage("groovy script"){
            steps {
                script {
                    gv.hello_scriptor()
                }
            }
        }

    }
    post {
        always {
            steps{
                echo "toodles"
            }
        }
    }
}  
