// Jenkinsfile
//String credentialId = 'awsCredentials'

pipeline {
    agent any
    environment {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awsCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])
    }
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
                                     
                sh 'terraform init' 
                
            }
        }

    // Run terraform plan
        stage('plan') {
            steps {
                    
                    sh 'terraform plan'   
            }
        }

        
   // Run terraform apply
        stage('apply') {
            steps {
                    
                    sh 'terraform apply --auto-approve'
                    
            }
        }
        
    // Run terraform show
        stage('show') {
            steps {
                    
                    sh 'terraform show'
                    
            }
        }
    }
}

