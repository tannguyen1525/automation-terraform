// Jenkinsfile
//String credentialId = 'awsCredentials'

pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

    environment {
        AWS_ACCESS_KEY_ID     = awsCredentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = awsCredentials('AWS_SECRET_ACCESS_KEY')
        TF_IN_AUTOMATION      = '1'
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

