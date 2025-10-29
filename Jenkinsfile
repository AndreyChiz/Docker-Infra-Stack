pipeline {
    agent any

    options {
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
    }

    stages {

        stage('Checkout') {
            steps {
                echo "🔄 Checking out code..."
                checkout scm
            }
        }

        // ----------------- docker_registry -----------------
        stage('Deploy docker_registry') {
            steps {
                script {
                    def changed = sh(
                        script: "git diff --name-only HEAD~1 HEAD | grep -E 'docker_registry/docker-compose.yaml' || true",
                        returnStdout: true
                    ).trim()
                    if (changed) {
                        echo "🚀 Deploying docker_registry"
                        withCredentials([
                            usernamePassword(
                                credentialsId: 'docker_registry_cred',
                                usernameVariable: 'DOCKER_USER',
                                passwordVariable: 'DOCKER_PASS'
                            )
                        ]) {
                            sh """
                                cd docker_registry
                                export DOCKER_USER=${DOCKER_USER}
                                export DOCKER_PASS=${DOCKER_PASS}
                                docker-compose pull
                                docker-compose up -d --remove-orphans
                            """
                        }
                    } else {
                        echo "⏭ Skipping docker_registry"
                    }
                }
            }
        }

        // ----------------- jenkins -----------------
        stage('Deploy jenkins') {
            steps {
                script {
                    def changed = sh(
                        script: "git diff --name-only HEAD~1 HEAD | grep -E 'jenkins/docker-compose.yaml' || true",
                        returnStdout: true
                    ).trim()
                    if (changed) {
                        echo "🚀 Deploying jenkins"
                        withCredentials([
                            usernamePassword(
                                credentialsId: 'jenkins_cred',
                                usernameVariable: 'DOCKER_USER',
                                passwordVariable: 'DOCKER_PASS'
                            )
                        ]) {
                            sh """
                                cd jenkins
                                export DOCKER_USER=${DOCKER_USER}
                                export DOCKER_PASS=${DOCKER_PASS}
                                docker-compose pull
                                docker-compose up -d --remove-orphans
                            """
                        }
                    } else {
                        echo "⏭ Skipping jenkins"
                    }
                }
            }
        }

        // ----------------- monitoring -----------------
        stage('Deploy monitoring') {
            steps {
                script {
                    def changed = sh(
                        script: "git diff --name-only HEAD~1 HEAD | grep -E 'monitoring/docker-compose.yml' || true",
                        returnStdout: true
                    ).trim()
                    if (changed) {
                        echo "🚀 Deploying monitoring"
                        withCredentials([
                            usernamePassword(
                                credentialsId: 'monitoring_cred',
                                usernameVariable: 'DOCKER_USER',
                                passwordVariable: 'DOCKER_PASS'
                            )
                        ]) {
                            sh """
                                cd monitoring
                                export DOCKER_USER=${DOCKER_USER}
                                export DOCKER_PASS=${DOCKER_PASS}
                                docker-compose pull
                                docker-compose up -d --remove-orphans
                            """
                        }
                    } else {
                        echo "⏭ Skipping monitoring"
                    }
                }
            }
        }

        // ----------------- postgres -----------------
        stage('Deploy postgres') {
            steps {
                script {
                    def changed = sh(
                        script: "git diff --name-only HEAD~1 HEAD | grep -E 'postgres/docker-compose.yaml' || true",
                        returnStdout: true
                    ).trim()
                    if (changed) {
                        echo "🚀 Deploying postgres"
                        withCredentials([
                            usernamePassword(
                                credentialsId: 'postgres_cred',
                                usernameVariable: 'PG_USER',
                                passwordVariable: 'PG_PASS'
                            )
                        ]) {
                            sh """
                                cd postgres
                                export PG_USER=${PG_USER}
                                export PG_PASS=${PG_PASS}
                                docker-compose pull
                                docker-compose up -d --remove-orphans
                            """
                        }
                    } else {
                        echo "⏭ Skipping postgres"
                    }
                }
            }
        }

        // ----------------- traefik -----------------
        stage('Deploy traefik') {
            steps {
                script {
                    def changed = sh(
                        script: "git diff --name-only HEAD~1 HEAD | grep -E 'traefik/docker-compose.yaml' || true",
                        returnStdout: true
                    ).trim()
                    if (changed) {
                        echo "🚀 Deploying traefik"
                        withCredentials([
                            usernamePassword(
                                credentialsId: 'traefik_cred',
                                usernameVariable: 'DOCKER_USER',
                                passwordVariable: 'DOCKER_PASS'
                            )
                        ]) {
                            sh """
                                cd traefik
                                export DOCKER_USER=${DOCKER_USER}
                                export DOCKER_PASS=${DOCKER_PASS}
                                docker-compose pull
                                docker-compose up -d --remove-orphans
                            """
                        }
                    } else {
                        echo "⏭ Skipping traefik"
                    }
                }
            }
        }

    }

    post {
        always {
            echo "✅ Pipeline finished."
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}
