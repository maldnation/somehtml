pipeline {
    agent {label "docker"}
    environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }
    stages { 
        stage('SCM Checkout') {
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/html']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'git@github.com:InZeinly/somehtml.git']]])
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
                sh 'ssh -Ti -o StrictHostKeyChecking=no -i ~/aws-terraform.pem ssh ubuntu@ec2-3-73-78-110.eu-central-1.compute.amazonaws.com '
            }
        }
        stage("Pull image from Deploy") {
            steps{
                sh 'docker pull inzein/htmlimage:47'
            }
        }
}
post {
        always {
            sh 'docker logout'
        }
    }
}
