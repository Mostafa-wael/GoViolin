def gv
pipeline {
    agent any
    parameters {
        booleanParam(name: 'push_image', defaultValue: false, description: 'whether to push the image to docker hub or not')
    }
    environment{
        REPO_URL = 'https://github.com/Rosalita/GoViolin'
        IMAGE_NAME = 'mostafaw/goviolin'
        DOCKER_IMAGE = ''
        DOCKERHUB_CREDENTIALS='dockerhub_cred'
    }
    stages {
        stage("init") { // just initializing the pipeline
            steps {
                script {
                   echo 'Initializing the pipeline...'
                   gv = load "script.groovy" 
                }
            }
            post {
                success {
                    echo "======== Initialization Success ========"
                }
                failure {
                    echo "======== Initialization Failed ========"
                }
           }
        }
        // stage('Clone the repo') { // cloning the repo everytime the pipeline is run
        //     steps {
        //         script {
        //             echo 'Cloning the repo...'
        //             gv.cloneTheRepo(repo_url: environment.REPO_URL)
        //         }
        //     }
        // }
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