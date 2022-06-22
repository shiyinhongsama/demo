pipeline {
  agent none
  stages {
    stage('Build') {
      agent {
        docker {
          image 'maven:3.8.4-openjdk-8'
          args '''-v /root/.m2:/root/.m2 
-v  "/var/run/docker.sock:/var/run/docker.sock"'''
        }

      }
      steps {
        sh '''mvn -B -DskipTests clean package
echo $PWD
ls -la'''
      }
    }

  }
}