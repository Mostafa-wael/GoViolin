pipeline {
    agent any
    environment{
        REPO_URL = 'https://github.com/Rosalita/GoViolin'
        IMAGE_NAME = 'mostafaw/GoViolin'
        DOCKER_IMAGE = ''

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
        stage('Push')
        {
            steps{

            withCredentials([usernamePassword(credentialsId: 'dockerhub_cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')])
                sh """
                    docker login -u ${USERNAME} -p ${PASSWORD}
                    docker push $DOCKER_IMAGE
                """    
            }
        }
    }
}