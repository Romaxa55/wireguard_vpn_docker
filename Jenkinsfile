pipeline {
    agent { node { label 'slave' } }

    environment {
        TEST_PREFIX = "test-IMAGE"
        TEST_IMAGE = "${env.TEST_PREFIX}:${env.BUILD_NUMBER}"
        TEST_CONTAINER = "${env.TEST_PREFIX}-${env.BUILD_NUMBER}"
        REGISTRY_ADDRESS = "my.registry.address.com"


        COMPOSE_FILE = "docker-compose.yml"
        REGISTRY_AUTH = credentials("dickerLogin")
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
                sh "docker ps"
                sh "docker logs"
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