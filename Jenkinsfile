pipeline {
    agent any

    environment {
        AZURE_CLIENT_ID       = credentials('AZURE_CLIENT_ID')
        AZURE_CLIENT_SECRET   = credentials('AZURE_CLIENT_SECRET')
        AZURE_TENANT_ID       = credentials('AZURE_TENANT_ID')
        AZURE_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
        TERRAFORM             = 'C:\\Terraform\\terraform.exe'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Login to Azure') {
            steps {
                bat '''
                    az login --service-principal ^
                        --username %AZURE_CLIENT_ID% ^
                        --password %AZURE_CLIENT_SECRET% ^
                        --tenant %AZURE_TENANT_ID%
                    az account set --subscription %AZURE_SUBSCRIPTION_ID%
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                bat '%TERRAFORM% init'
            }
        }

        stage('Terraform Apply') {
            steps {
                bat '%TERRAFORM% apply -auto-approve'
            }
        }

        stage('Get Public IP') {
            steps {
                script {
                    env.PUBLIC_IP = bat(
                        script: "%TERRAFORM% output -raw vm_public_ip",
                        returnStdout: true
                    ).trim()
                    echo "IP Pública obtenida: ${env.PUBLIC_IP}"
                }
            }
        }

        stage('Check Apache') {
            steps {
                script {
                    def result = bat(
                        script: "curl -s -o NUL -w \"%%{http_code}\" http://${env.PUBLIC_IP}",
                        returnStdout: true
                    ).trim()
                    if (result == '200') {
                        echo "Apache está funcionando correctamente en ${env.PUBLIC_IP}"
                    } else {
                        error("Apache no está funcionando correctamente. Código HTTP: ${result}")
                    }
                }
            }
        }
    }
}
