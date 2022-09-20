pipeline {
    agent {label "docker"}
    environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-hub-inzein')
    }
    stages { 
        stage('SCM Checkout') {
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/html']], extensions: [], userRemoteConfigs: [[credentialsId: 'ubuntuMaster', url: 'git@github.com:InZeinly/somehtml.git']]])
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
        stage('Connect to deploy') {
            steps{
                sh 'ssh -Ti ~/aws-terraform.pem ubuntu@ec2-3-73-42-4.eu-central-1.compute.amazonaws.com'
            }
        }
        stage('whoami') {
            steps{
                sh "whoami"
}
post {
        always {
            sh 'docker logout'
        }
    }
}
