pipeline {
    agent any

    environment {
        // AWS credentials stored securely in Jenkins Credentials
        AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Clone Terraform Repo') {
            steps {
                git url: 'https://github.com/KarishmaAbruk/devops_demo.git', branch: 'main'
            }
        }

        stage('Initialize Terraform') {
            steps {
                sh 'terraform init -no-color'
            }
        }

        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check -no-color || true'
            }
        }

        stage('Validate Terraform Code') {
            steps {
                script {
                    def start = System.currentTimeMillis()
                    sh 'terraform validate -no-color'
                    def duration = (System.currentTimeMillis() - start) / 1000
                    echo "Terraform validation completed in ${duration} seconds."
                }
            }
        }

        stage('Plan Infrastructure') {
            steps {
                sh 'terraform plan -no-color -out=tfplan'
            }
        }

        stage('Apply Infrastructure') {
            steps {
                input message: 'Proceed to apply Terraform plan?', ok: 'Apply'
                sh 'terraform apply -no-color -auto-approve tfplan'
            }
        }
    }

    post {
        failure {
            echo 'Terraform pipeline failed.'
        }
        success {
            echo 'Terraform pipeline completed successfully.'
        }
    }
}
