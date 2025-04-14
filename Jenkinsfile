pipeline {
    agent any
    
    tools{
        maven 'maven'
    }
    environment {
        KUBECONFIG = "/home/harsh/.kube/config"
    }
    stages {
        stage('GIT CLONE') {
            steps {
                git credentialsId: 'GIT_CRED', url: 'https://github.com/Harshyadav02/Simple-Spring-Boot-Project.git'
            }
        }
        
        stage("MAVEN BUILD") {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        
        stage("DOCKER IMAGE BUILD") {
            steps {
                sh 'docker build -t harshyadav02/simple-project .'
            }
        }
        stage("PUSH TO DOCKER HUB"){
            
            steps{
                
                withCredentials([string(credentialsId: 'Docker-hub-cred', variable: 'DockerHub')]) {
                    
                    sh 'docker login -u harshyadav02 -p ${DockerHub}'
                    sh 'docker push harshyadav02/simple-project'
                }
            }
        }
        
        stage("Deploy to K8s"){
            
            steps{
                sh "kubectl apply -f k8s.yaml"
            }
        }
    }
}
