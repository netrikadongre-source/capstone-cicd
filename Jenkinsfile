pipeline {
    agent any

    environment {
        AWS_SERVER = "ubuntu@3.86.227.252"
        AZURE_SERVER = "azureuser@4.246.153.93"
    }

    stages {

        stage('Checkout Code') {
            steps {
                sshagent(['github-key']) {
                    git branch: 'main', url: 'git@github.com:netrikadongre-source/capstone-cicd.git'
                }
            }
        }

        stage('Deploy to AWS') {
            steps {
                sshagent(['aws-server']) {
                    sh """
                    scp -o StrictHostKeyChecking=no ansible/index-aws.html $AWS_SERVER:/var/www/html/index.html
                    ssh -o StrictHostKeyChecking=no $AWS_SERVER 'sudo systemctl restart nginx'
                    """
                }
            }
        }

        stage('Deploy to Azure') {
            steps {
                sshagent(['azure-server']) {
                    sh """
                    scp -o StrictHostKeyChecking=no ansible/index-azure.html $AZURE_SERVER:/var/www/html/index.html
                    ssh -o StrictHostKeyChecking=no $AZURE_SERVER 'sudo systemctl restart nginx'
                    """
                }
            }
        }
    }

    post {
        success {
            echo "🎉 Deployment Successful on AWS & Azure!"
        }
        failure {
            echo "❌ Deployment Failed. Check console logs."
        }
    }
}

