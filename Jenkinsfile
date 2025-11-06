pipeline {
    agent any

    options {
        timestamps()
        timeout(time: 20, unit: 'MINUTES')
    }

    environment {
        DOCKER_BUILDKIT = "1"
        // HOST = "chiz.work.gd"
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
                    // echo "⚠️ HOST=${env.HOST}"
                    echo "⚠️ $HOST"
                }
            }
        }



        stage('Run All Services') {
            steps {
                    sh './scripts/bootstrap.sh'

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
