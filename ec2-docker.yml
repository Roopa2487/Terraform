pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = 'AKIAQ3EGSYLLKNX556U6'
        AWS_SECRET_ACCESS_KEY = 'sk6Zgbu+P6Yzc7KvSILl+wvNRKRtwkB8/SAbp9mG'
        AWS_DEFAULT_REGION    = 'ap-south-1'  // Change to your desired region
    }

    stages {
        stage('Clone GitHub Repository') {
            steps {
                script {
                    // Clone your GitHub repository
                    git url: 'https://github.com/Roopa2487/Terraform.git', branch: 'main'
                }
            }
        }

        stage('Install Docker') {
            steps {
                script {
                    // Install Docker using Docker Compose
                    sh 'sudo apt update'
                    sh 'sudo apt install apt-transport-https ca-certificates curl software-properties-common'
                    sh 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'
                    sh 'sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"'
                    sh 'apt-cache policy docker-ce'
                    sh 'sudo apt install docker-ce'
                    sh 'sudo systemctl status docker'
                    sh 'sudo chmod 777 /var/run/docker.sock'
                    sh 'docker -ps'
                }
            }
        }

        stage('Provision EC2 Instance') {
            steps {
                script {
                    // Install Terraform (adjust the version as needed)
                    sh 'sudo apt-get update && sudo apt-get install -y unzip'
                    sh 'wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg'
                    sh 'echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list'
                    sh 'sudo apt update && sudo apt install terraform'

                    // Initialize and apply Terraform configuration
                    sh 'terraform init path/home/ubuntu/terraform/directory'
                    sh 'terraform apply -auto-approve path/home/ubuntu/terraform/directory'
                }
            }
        }

        stage('Test Docker on EC2') {
            steps {
                script {
                    // Retrieve EC2 instance IP
                    def ec2Ip = sh(script: 'terraform output -json public_ip | jq -r .[0]', returnStdout: true).trim()

                    // SSH into the EC2 instance and check Docker version
                    sh "ssh -i /path/to/your/key.pem ec2-user@${ec2Ip} 'docker --version'"
                }
            }
        }
    }
}
