pipeline {
  agent none
  parameters {
          booleanParam(name: 'EXEC_PERFORMANCE_TEST', defaultValue: false, description: '是否执行性能测试?')
          string(name: 'SCRIPT_NAME', defaultValue: 'SimpleTestPlan.jmx', description: '测试脚本名称')
          booleanParam(name: 'SEND_MAIL', defaultValue: false, description: '性能测试结果是否发送邮件')
     }
  options{
    skipDefaultCheckout true
  }
  stages {
    agent any
    stege('clone code'){
        steps{
            git credentialsId: "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", url: "https://github.com/shiyinhongsama/demo.git"
        }
    }
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
        sh '''word=`docker ps -a | grep demo:0.0.1 | awk \'{print $1}\'`


if [ -n "$word" ] ;then
  echo "stopping old container"
  docker rm -f $(docker ps -a | grep demo:0.0.1 | awk \'{print $1}\')
fi
docker run -itd --name demo -p 8002:8080 demo:0.0.1'''
      }
    }

  }
}