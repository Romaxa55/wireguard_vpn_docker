node ("slave") {
  try {
    stage('checkout') {
      checkout scm
    }
    stage('prepare') {
      sh "git clean -fdx"
    }
    stage('compile') {
      sh "docker-compose build"
      sh "docker-compose up -d"
      sh "docker-compose ps"

    }

  } finally {
    stage('cleanup') {
        sh "docker-compose down || true"
    }

  }
}