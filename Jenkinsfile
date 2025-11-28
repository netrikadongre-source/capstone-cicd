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
                    echo "📦 Copying file to AWS..."
                    scp -o StrictHostKeyChecking=no ansible/index-aws.html $AWS_SERVER:/tmp/index.html
                    
                    echo "🚀 Deploying on AWS server..."
                    ssh -o StrictHostKeyChecking=no $AWS_SERVER '
                        sudo mv /tmp/index.html /var/www/html/index.html &&
                        sudo chown www-data:www-data /var/www/html/index.html &&
                        sudo systemctl restart nginx
                    '
                    """
                }
            }
        }

        stage('Deploy to Azure') {
            steps {
                sshagent(['azure-server']) {
                    sh """
                    echo "📦 Copying file to Azure..."
                    scp -o StrictHostKeyChecking=no ansible/index-azure.html $AZURE_SERVER:/tmp/index.html
                    
                    echo "🚀 Deploying on Azure server..."
                    ssh -o StrictHostKeyChecking=no $AZURE_SERVER '
                        sudo mv /tmp/index.html /var/www/html/index.html &&
                        sudo chown www-data:www-data /var/www/html/index.html &&
                        sudo systemctl restart nginx
                    '
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
            echo "❌ Deployment Failed. Check pipeline logs."
        }
    }
}

