pipeline {
  agent {
    docker {
      args '''-v /root/.m2:/root/.m2
-v  /var/run/docker.sock:/var/run/docker.sock'''
      image 'maven:3.8.4-openjdk-8'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }

    stage('UnitTest') {
      post {
        always {
          junit 'target/surefire-reports/*.xml'
        }

      }
      steps {
        sh 'mvn test'
      }
    }

    stage('Deliver') {
      steps {
        sh '''docker build -t demo:0.0.1 .

word= `sudo docker ps -a | grep demo:0.0.1 | awk \'{print $1}\'`

if [ -z "$word" ] ;then
  echo "stopping old container" \\
  && sudo docker rm -f $(docker ps -a | grep demo:0.0.1 | awk \'{print $1}\')
fi

sudo docker run -itd --name demo -p 8002:8080 demo:0.0.1'''
      }
    }

  }
}