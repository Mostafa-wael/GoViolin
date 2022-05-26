pipeline {
    agent any
    parameters {
        booleanParam(name: 'run_tests', defaultValue: false, description: 'whether to test the repo or not')
        booleanParam(name: 'build_image', defaultValue: false, description: 'whether to build the image or not')
        booleanParam(name: 'push_image', defaultValue: false, description: 'whether to push the image to docker hub or not')
        booleanParam(name: 'deploy', defaultValue: false, description: 'whether to deploy the service or not')
    }
    environment{
        DOCKERHUB_REGISTRY ='mostafaw'
        IMAGE_TAG = 'latest' //  or ${BUILD_NUMBER}
        IMAGE_NAME = 'goviolin'
        DOCKERHUB_CREDENTIALS='dockerhub_cred'
        EMAIL = 'mostafa.w.k000@gmail.com'
        GO111MODULE = 'on'
        root = tool type: 'go', name: 'GO 1.16' //Ensure the desired Go version is installed
    }
    stages {
        stage('Test') {
            when {
                expression {
                    params.run_tests
                }
            }
            steps {
                // Export environment variables pointing to the directory where Go was installed and run steps
                withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin", "GOBIN=${root}/bin", "GOPATH=${root}/go"]) {
                  sh """
                    go mod tidy
                    go mod vendor
                    go test ./... 
                    """   
                }
            }
            post {
                success {
                    echo "======== Tests Success ========"
                    mail to: "${EMAIL}",subject: "GoViolin Pipeline Succeded",body: "All the tests passed"
                }
                failure {
                    echo "======== Tests Failed ========"
                    mail to: "${EMAIL}",subject: "GoViolin Pipeline Failed",body: "Tests failed"
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
                    sh 'docker build -t ${DOCKERHUB_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} .'
                }
            }
           post {
                success {
                    echo "======== Build Success ========"
                    mail to: "${EMAIL}",subject: "GoViolin Pipeline Succeded",body: "The pipeline managed to build the image"
                }
                failure {
                    echo "======== Build Failed ========"
                    mail to: "${EMAIL}",subject: "GoViolin Pipeline Failed",body: "The pipeline failed to build the image"
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
                        docker push ${DOCKERHUB_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
                    """    
                } 
            }
             post {
                success {
                    echo "======== Push Success ========"
                    mail to: "${EMAIL}",subject: "GoViolin Pipeline Succeded",body: "The pipeline managed to push the image to Docker Hub"
                }
                failure {
                    echo "======== Push Failed ========"
                    mail to: "${EMAIL}",subject: "GoViolin Pipeline Failed",body: "The pipeline failed to push the image to Docker Hub"
                }
           }
        } 
        stage('Deploy the service using Helm') {
            when {
                expression {
                    params.deploy
                }
            }
            steps { 
                    sh 'helm upgrade --install goviolin-chart  ./goviolin-chart'
            }
             post {
                success {
                    echo "======== Deployemnt Success ========"
                    mail to: "${EMAIL}",subject: "GoViolin Pipeline Succeded",body: "The pipeline managed to deploy the service"
                }
                failure {
                    echo "======== Deployemnt Failed ========"
                    mail to: "${EMAIL}",subject: "GoViolin Pipeline Failed",body: "The pipeline failed to deploy the service"
                }
           }
        } 
}
