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
    stage('test') {
      try {
        timeout(1000, unit: SECONDS) {
          sh "chmod +x ./scripts/check.sh"
          sh "./scripts/check.sh"
        }
      } catch(e) {
        print(e)
      }
    }
  } finally {
    stage('cleanup') {
        sh "docker-compose down || true"
    }

  }
}