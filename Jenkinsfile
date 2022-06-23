pipeline {
  agent none
  stages {
    stage('build Jar') {
      agent {
        docker {
          image 'maven:3.8.4-openjdk-8'
          args '''-v /root/.m2:/root/.m2 
-v  "/var/run/docker.sock:/var/run/docker.sock"'''
        }

      }
      steps {
        sh '''mvn -B -DskipTests clean package
ls -la'''
        stash(name: 'jar', includes: '**/target/*.jar')
      }
    }

    stage('build images') {
      agent any
      steps {
        unstash 'jar'
        sh 'docker build -t demo:0.0.1 .'
      }
    }

    stage('deploy container') {
      agent any
      steps {
        unstash 'jar'
        sh '''word= `docker ps -a | grep demo:0.0.1 | awk \'{print $1}\'`
if [ -z "$word" ] ;then
  echo "stopping old container"
  docker rm -f $(docker ps -a | grep demo:0.0.1 | awk \'{print $1}\')
fi
docker run -itd --name demo -p 8002:8080 demo:0.0.1'''
      }
    }

  }
}