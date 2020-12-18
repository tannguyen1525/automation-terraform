// Jenkinsfile
//String credentialId = 'awsCredentials'

pipeline {
    agent any
    
    stages {
        stage('checkout') {
            steps {
                cleanWs ()
                checkout scm
            }
        }   

    // Run terraform init
        stage('init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awsCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    
                sh 'terraform init'
                    
                }
            }
        }

    // Run terraform plan
        stage('plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awsCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    
                    sh 'terraform plan'
                    
                }
            }
        }

        
   // Run terraform apply
        stage('apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awsCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    
                    sh 'terraform apply --auto-approve'
                    
                }
            }
        }
        
    // Run terraform show
        stage('show') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awsCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    
                    sh 'terraform show'
                    
                }
            }
        }
    }
}

