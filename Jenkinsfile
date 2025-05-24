pipeline {
    agent any

    environment {
        // Set AWS credentials (these should be stored in Jenkins credentials securely)
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION = 'us-east-1'  // Change to your desired region
    }

    stages {
        stage('Clone Terraform Repo') {
            steps {
                git url: '', branch: 'main'
            }
        }

        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        } 
        stage('Terraform Format') { 
            steps { 
                sh 'terraform fmt -check || exit 0' 
            } 

        }

        stage('Validate Terraform Code') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Plan Infrastructure') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Apply Infrastructure') {
            steps {
                input message: 'Apply Terraform plan?', ok: 'Apply'
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        failure {
            echo "Terraform apply failed"
        }
        success {
            echo "EC2 instance successfully created using Terraform"
        }
    }
}
