pipeline {
    agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }

  stages {
      stage('Checkout') {
          steps {
              git credentialsId: 'GitHubCreds', url: 'https://github.com/daniel-develeap/webapp.git'
          }
      }
    stage('Build') {
      steps {
        sh 'docker build -t daniel570/java-app:4.$BUILD_ID .'
      }
    }
    
    stage('Publish') {
      steps {
          withDockerRegistry(credentialsId: 'DockerHubCreds', url: 'https://index.docker.io/v1/') {
          sh 'docker push daniel570/java-app:4.$BUILD_ID'
        }
      }
    }
    stage('Deploy') {
        steps {
            sh 'cd helm-charts && helm upgrade appdb-chart appdb-chart'
        }
    }
  }
}
