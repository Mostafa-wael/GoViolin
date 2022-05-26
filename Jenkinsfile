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
    }
    stages {
        when {
                expression {
                    params.run_tests
                }
            }
        stage('Test') {
            environment {
                GOPATH = '/root/go'
                GOMODCACHE = '/root/go/pkg/mod'
                GOCACHE = '/root/.cache/go-build'
                GOENV = '/root/.config/go/env'
            }
            agent {
                // Use the Dockerfile as the agent.
                dockerfile {
                    filename 'Dockerfile'
                    dir '.'
                    // Stop at the builder stage to access the test files
                    additionalBuildArgs  '--target builder' 
                    // Run as root and share pkg folder between host and docker for caching
                    args '-v $HOME/go/pkg:/root/go/pkg --user 0' 
                    reuseNode true
                }
            }
            steps {
                sh 'go test -v ./...'
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