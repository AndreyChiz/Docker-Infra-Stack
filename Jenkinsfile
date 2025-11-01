pipeline {
    agent any

    options {
        timestamps()
        timeout(time: 20, unit: 'MINUTES')
    }

    environment {
        DOCKER_BUILDKIT = "1"
        HOST = "chiz.work.gd"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "🔄 Checking out code..."
                checkout scm
            }
        }

        stage('Set Variables') {
            steps {
                script {
                    echo "⚠️ HOST=${env.HOST}"
                }
            }
        }



        stage('Run All Services') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'privat_docker_registry_cred',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    // Запуск скрипта, который поднимает все docker-compose сервисы с прокидкой HOST
                    sh './scripts/run.sh'
                }
            }
        }

    }

    post {
        always {
            echo "✅ Pipeline finished."
            echo "🧹 Cleaning workspace..."
            deleteDir()
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}
