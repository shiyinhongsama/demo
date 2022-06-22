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
      }
    }

    stage('build images') {
      agent any
      steps {
        sh 'docker build -t demo:0.0.1 .'
      }
    }

    stage('deploy container') {
      agent any
      steps {
        sh '''word= `sudo docker ps -a | grep demo:0.0.1 | awk \\\\\\\'{print $1}\\\\\\\'`
if [ -z "$word" ] ;then
  echo "stopping old container" \\\\\\\\
  && sudo docker rm -f $(docker ps -a | grep demo:0.0.1 | awk \\\\\\\'{print $1}\\\\\\\')
fi
sudo docker run -itd --name demo -p 8002:8080 demo:0.0.1'''
      }
    }

  }
}