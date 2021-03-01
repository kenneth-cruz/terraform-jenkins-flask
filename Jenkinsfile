pipeline {
    agent any
    } 
    stages {
        stage("Checkout from SCM") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kenneth-cruz/terraform-jenkins-flask']]])
            }
        } 
        stage("Create Kubernetes Deployment and Service") {
            steps {
                sh 'terraform init'
                sh 'pwd'
                sh 'terraform validate'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}