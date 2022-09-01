pipeline {
    agent { node { label 'slave' } }

    environment {
        TEST_PREFIX = "test-IMAGE"
        TEST_IMAGE = "${env.TEST_PREFIX}:${env.BUILD_NUMBER}"
        TEST_CONTAINER = "${env.TEST_PREFIX}-${env.BUILD_NUMBER}"
        REGISTRY_ADDRESS = "my.registry.address.com"


        COMPOSE_FILE = "docker-compose.yml"
        STACK_PREFIX = "my-project-stack-name"
    }

    stages {

        stage("Build and start image") {
            steps {
                sh "docker-compose build"
                sh "docker-compose up -d"
            }
        }

        stage("Run tests") {
            steps {
                try {
                  timeout(1000, unit: SECONDS) {
                    sh "docker wait wireguard"
                  }
                } catch(e) {
                  sh "docker stop wireguard"
                  sh "docker wait wireguard" // <= 10s, container is guaranteed to be stopped
                }
                sh "docker rm wireguard"
            }

        }

    }

    post {
      always {
          sh "docker-compose down || true"
      }

      success {
            echo 'I succeeded!'
      }

      failure {
            echo 'I failed :('
      }
    }
}