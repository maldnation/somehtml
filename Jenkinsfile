pipeline {
    agent any 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-hub-inzein')
    }
    stages { 
        stage('SCM Checkout') {
            steps{
            git 'https://github.com/InZeinly/somehtml.git'
            }
        }

        stage('Build docker image') {
            steps {  
                sh 'docker build -t inzein/htmlimage:$BUILD_NUMBER .'
            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps{
                sh 'docker push inzein/htmlimage:$BUILD_NUMBER'
            }
        }
}
post {
        always {
            sh 'docker logout'
        }
    }
}
