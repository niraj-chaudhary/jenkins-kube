pipeline {
    agent any
    environment{
	DOCKER_TAG = getDockerTag()
    }
    stages{
       stage('Build Docker Image'){
	  steps{
		sh "docker build -t demo/pythonapp:${DOCKER_TAG}"
	  }
       }
    }
}

def getDockerTag(){
	def tag = sh script: 'git rev-parse HEAD', retirnStdout: true
	return tag
}
