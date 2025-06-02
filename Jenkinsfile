pipeline {
    agent any

    environment {
        AZURE_CLIENT_ID       = credentials('AZURE_CLIENT_ID')
        AZURE_CLIENT_SECRET   = credentials('AZURE_CLIENT_SECRET')
        AZURE_TENANT_ID       = credentials('AZURE_TENANT_ID')
        AZURE_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
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
                bat 'C:\\Terraform\\terraform.exe init'
            }
        }

        stage('Terraform Apply') {
            steps {
                bat 'C:\\Terraform\\terraform.exe apply -auto-approve'
            }
        }

        stage('Get Public IP') {
            steps {
                script {
                    def output = bat(
                        script: 'C:\\Terraform\\terraform.exe output -raw vm_public_ip',
                        returnStdout: true
                    ).trim()
                    env.PUBLIC_IP = output
                    echo "IP Pública obtenida: ${env.PUBLIC_IP}"
                }
            }
        }

        stage('Esperar Apache') {
            steps {
                echo "Esperando 30 segundos para que Apache se inicie..."
                sleep time: 30, unit: 'SECONDS'
            }
        }

        stage('Check Apache') {
            steps {
                script {
                    def result = bat(
                        script: "curl -s -o NUL -w \"%%{http_code}\" http://${env.PUBLIC_IP}",
                        returnStdout: true
                    ).trim()
                    echo "Código HTTP devuelto: ${result}"
                    if (result == '200') {
                        echo "Apache está funcionando correctamente en ${env.PUBLIC_IP}"
                    } else {
                        error("Apache no está funcionando correctamente. Código HTTP: ${result}")
                    }
                }
            }
        }

        stage('Esperar antes de destruir') {
            steps {
                echo "Esperando 3 minutos antes de destruir los recursos..."
                sleep time: 3, unit: 'MINUTES'
            }
        }

        stage('Terraform Destroy') {
            steps {
                bat 'C:\\Terraform\\terraform.exe destroy -auto-approve'
            }
        }
    }
}
