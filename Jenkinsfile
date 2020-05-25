pipeline {
    agent any
    environment{
	DOCKER_TAG = getDockerTag()
    }
    stages{
       stage('Build Docker Image'){
	  steps{
		sh "docker build  . -t nirajcoss/pythonapp:${DOCKER_TAG}"
	  }
       }
      stage('DockerHub Push'){
          steps{
		withCredentials([string(credentialsId: 'docker-hub', variable: 'Docker-Hub')]) {
    			sh "docker login -u nirajcoss -p ${Docker-Hub}"
			sh "docker push nirajcoss/pythonapp:${DOCKER_TAG}"
		}	
	  }
      }
      stage('Deploy to k8s'){
     	  steps{
		sh "chmod +x changeTag.sh"
		sh "./changeTag.sh ${DOCKER_TAG}"
		sshagent(['kops-system']) {
 		   sh "scp -o StrictHostKeyChecking=no services.yml python-app-pod.yml ubuntu@192.168.34.4:~/"
		   script{
		       try{
		       	   sh "ssh ubuntu@192.168.34.4 kubectl apply -f ."
		       }catch(error){
				sh "ssh ubuntu@192.168.34.4 kubectl create -f ."
			}
		   }
		}
	  }
      }
    }
}

def getDockerTag(){
	def tag = sh script: 'git rev-parse HEAD', returnStdout: true
	return tag
}
