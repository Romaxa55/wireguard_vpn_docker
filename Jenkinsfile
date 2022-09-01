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
    }
    stage('test') {
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
  } finally {
    stage('cleanup') {
      echo "doing some cleanup..."
    }
  }
}