// Jenkinsfile
//String credentialId = 'awsCredentials'

pipeline {
    agent any
    stage('checkout') {
        node {
            cleanWs ()
            checkout scm
        }
    }

    // Run terraform init
    stage('init') {
        node {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awsCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                ansiColor{
                    sh 'terraform init'
                }
            }
        }
    }

    // Run terraform plan
    stage('plan') {
        node {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awsCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                ansiColor{
                    sh 'terraform plan'
                }
            }
        }
    }

        
   // Run terraform apply
    stage('apply') {
       node {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awsCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                ansiColor{
                    sh 'terraform apply --auto-approve'
                }
            }
        }
    }
        
    // Run terraform show
    stage('show') {
        node {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awsCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                ansiColor{
                    sh 'terraform show'
                    }
                }
            }
        }
   
}

