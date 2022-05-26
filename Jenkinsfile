pipeline {
    agent any
    parameters {
        booleanParam(name: 'run_tests', defaultValue: false, description: 'whether to test the repo or not')
        booleanParam(name: 'build_image', defaultValue: false, description: 'whether to build the image or not')
        booleanParam(name: 'push_image', defaultValue: false, description: 'whether to push the image to docker hub or not')
    }
    environment{
        DOCKERHUB_REGISTRY='mostafaw'
        IMAGE_NAME = 'goviolin'
        DOCKERHUB_CREDENTIALS='dockerhub_cred'
        EMAIL = 'mostafa.w.k000@gmail.com'
        root = tool type: 'go', name: 'GO 1.18' //Ensure the desired Go version is installed
    }
    stages {
        stage('Test') {
        when {
                expression {
                    params.run_tests
                }
            }
            environment {
                GOPATH = '/root/go'
                GOMODCACHE = '/root/go/pkg/mod'
                GOCACHE = '/root/.cache/go-build'
                GOENV = '/root/.config/go/env'
            }
           
            steps {
                // Export environment variables pointing to the directory where Go was installed and run steps
                withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
                    sh """
                        go mod vendor
                        go mod download
                        go mod verify
                        go test ./...
                    """    
                }
            }
        }

        stage('Build the Docker image') {
            when {
                expression {
                    params.build_image
                }
            }
            steps {
                script
                {
                    sh 'docker build -t ${DOCKERHUB_REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER} .'
                }
            }
           post {
                success {
                    echo "======== Build Success ========"
                    // mail to: "${EMAIL}",subject: "GoViolin Pipeline FaiSuccededled",body: "The pipeline managed to build the image"
                }
                failure {
                    echo "======== Build Failed ========"
                    // mail to: "${EMAIL}",subject: "GoViolin Pipeline Failed",body: "The pipeline failed to build the image"
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
                
                withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')])
                { 
                    sh """
                        docker login -u ${USERNAME} -p ${PASSWORD}
                        docker push ${DOCKERHUB_REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER}
                    """    
                } 
            }
             post {
                success {
                    echo "======== Push Success ========"
                    // mail to: "${EMAIL}",subject: "GoViolin Pipeline Succeded",body: "The pipeline managed to push the image to Docker Hub"
                }
                failure {
                    echo "======== Push Failed ========"
                    // mail to: "${EMAIL}",subject: "GoViolin Pipeline Failed",body: "The pipeline failed to push the image to Docker Hub"
                }
           }
        } 
	}
}