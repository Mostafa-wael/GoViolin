pipeline {
    agent any
    environment{
        REPO_URL = 'https://github.com/Rosalita/GoViolin'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_cred')
        IMAGE_NAME = 'mostafaw/GoViolin'
        DOCKER_IMAGE = ''


    }
    stages {
        stage('Clone git repo') {
            steps {
                sh 'rm -rf GoViolin'
                sh 'git clone $REPO_URL'
            }
        }
        stage('Build') {
            steps {
                script
                {
                    DOCKER_IMAGE = docker.build IMAGE_NAME + ":$BUILD_NUMBER" 
                }
            }
            post {
                  always
                    {
                        echo 'Finished..'
                    }
            }
        }
        stage('Push')
        {
            steps
            {
                script
                {
                    docker.withRegistry('https://registry.hub.docker.com', CREDENTIALS) 
                    {
                        DOCKER_IMAGE.push("latest")
                    }
                }
            }
        }
    }
}