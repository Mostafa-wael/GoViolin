pipeline {
    agent any
    environment{
        REPO_URL = 'https://github.com/Rosalita/GoViolin'
        IMAGE_NAME = 'mostafaw/GoViolin'
        DOCKER_IMAGE = ''
        DOCKERHUB_CREDENTIALS='dockerhub_cred'


    }
    stages {
        stage('Clone git repo') {
            steps {
                sh """
                    rm -rf GoViolin
                    git clone $REPO_URL
                """  
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
        stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', DOCKERHUB_CREDENTIALS ) { 
                        DOCKER_IMAGE.push() 
                    }
                } 
            }
        } 
	}
}