// Jenkinsfile
String credentialId = 'awsCredentials'

try {
    stage ('checkout') {
        node {
            cleanWs ()
            checkout scm
        }
    }

    // Run terraform init
    stage ('init') {
        wrappers {
            credentialsBinding {
                
                credentialId ("awsCredentials")
                accessKeyVariable ("AWS_ACCESS_KEY_ID")
                secretKeyVariable ("AWS_SECRET_ACCESS_KEY")
            } {
                ansiColor ('xterm') {
                    sh 'terraform init'
                }
            }
        }
    }

    // Run terraform plan
    stage ('plan') {
        wrappers {
            credentialsBinding {
                
                credentialId ("awsCredentials")
                accessKeyVariable ("AWS_ACCESS_KEY_ID")
                secretKeyVariable ("AWS_SECRET_ACCESS_KEY")
            } {
                ansiColor ('xterm') {
                    sh 'terraform plan'
                }
            }
        }
    }

    if (env.BARNCH_NAME == 'master' ) {
        
        // Run terraform apply
        stage ('apply') {
            wrappers {
            credentialsBinding {
                
                credentialId ("awsCredentials")
                accessKeyVariable ("AWS_ACCESS_KEY_ID")
                secretKeyVariable ("AWS_SECRET_ACCESS_KEY")
            } {
                ansiColor ('xterm') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
        
        // Run terraform show
        stage ('show') {
            wrappers {
            credentialsBinding {
                
                credentialId ("awsCredentials")
                accessKeyVariable ("AWS_ACCESS_KEY_ID")
                secretKeyVariable ("AWS_SECRET_ACCESS_KEY")
            } {
                ansiColor ('xterm') {
                    sh 'terraform show'
                }
            }
        }
        }
    }
    currentBuild.result = 'SUCCESS'
}

catch (err) {
    currentBuild.result = 'FAILURE'
    throw err
}
finally {
    if (currentBuild.result == 'SUCCESS') {
        currentBuild.result = 'SUCCESS'
    }
}
