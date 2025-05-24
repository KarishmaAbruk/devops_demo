pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    options {
        timeout(time: 15, unit: 'MINUTES') // Prevents long-running jobs
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Clone Terraform Repo') {
            steps {
                git url: 'https://github.com/KarishmaAbruk/devops-assessment--Karishma-abruk-containing-.git', branch: 'main'
            }
        }

        stage('Initialize Terraform') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Check Terraform Format') {
            steps {
                sh 'terraform fmt -check || true'
            }
        }

        stage('Validate Terraform') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Plan Infrastructure') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Approve and Apply Infrastructure') {
            steps {
                input message: 'Do you want to apply the Terraform plan?', ok: 'Yes, Apply'
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        success {
            echo '✅ EC2 instance successfully created using Terraform.'
        }
        failure {
            echo '❌ Terraform pipeline failed. Check logs for details.'
        }
    }
}
