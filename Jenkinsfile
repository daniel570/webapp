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
        sh '''
        svcIp=$(kubectl get service/oracledb -o yaml | grep clusterIP | cut -d ":" -f 2)
        ./curip.sh
        curIp=$(cat curip.txt)
        echo $curIp
        sed -i "s/$curIp/$svcIp/g" welcome.jsp
        sed -i "s/@ /@/g" welcome.jsp
        jar -cvf WebApp.war index.html META-INF/ WEB-INF/ welcome.jsp
        cat welcome.jsp
        ./curVer.sh
        curVer=$(cat version.txt)
        sed -i "s/$curVer/$curVer.$BUILD_ID/g" templates/deployment-webapp.yaml
        docker build -t daniel570/java-app:1.0.$BUILD_ID .
        '''
        }
      }
    
    stage('Publish') {
      steps {
        withDockerRegistry(credentialsId: 'DockerHubCreds', url: 'https://index.docker.io/v1/') {
        sh '''
        docker push daniel570/java-app:1.0.$BUILD_ID
        '''
        }
      }
    }
    stage('Deploy') {
        steps {
            git credentialsId: 'GitHubCreds', url: 'https://github.com/daniel-develeap/oracledb-temp.git'
            sh 'cd helm-charts && helm upgrade appdb appdb-chart'
        }
    }
  }
}
