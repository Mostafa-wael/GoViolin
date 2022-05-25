pipeline {
    agent any
    parameters {
        booleanParam(name: 'build_image', defaultValue: false, description: 'whether to build the image or not')
        booleanParam(name: 'push_image', defaultValue: false, description: 'whether to push the image to docker hub or not')
    }
    environment{
        REPO_URL = 'https://github.com/Rosalita/GoViolin'
        IMAGE_NAME = 'mostafaw/goviolin'
        DOCKER_IMAGE = ''
        DOCKERHUB_CREDENTIALS='dockerhub_cred'
        EMAIL = 'mostafa.w.k000@gmail.com'
    }
    stages {
        stage('Build the Docker image') {
            when {
                expression {
                    params.build_image
                }
            }
            steps {
                script
                {
                    DOCKER_IMAGE = docker.build IMAGE_NAME + ":$BUILD_NUMBER" 
                }
            }
           post {
                success {
                    echo "======== Build Success ========"
                }
                failure {
                    echo "======== Build Failed ========"
                    mail to: "${EMAIL}",subject: "GOViolin Pipeline Failed Build",body: "Docker Image Faild to built"

                }
           }
        }
        stage('Push The image to Docker Hub') { 
            when {
                expression {
                    params.build_image
                    params.push_image
                }
            }
            steps { 
                script { 
                    docker.withRegistry( '', DOCKERHUB_CREDENTIALS ) { 
                        DOCKER_IMAGE.push() 
                    }
                } 
            }
             post {
                success {
                    echo "======== Push Success ========"
                }
                failure {
                    echo "======== Push Failed ========"
                }
           }
        } 
	}
}