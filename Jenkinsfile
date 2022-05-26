pipeline {
    agent any
    parameters {
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
                sh 'cd GoViolin'
                // Get tool to convert go test results to JUnit XML reports.
                sh 'go get -u github.com/jstemmer/go-junit-report'
                // Redirect stderr to stdout and pipe both to the tool. Always return 0,
                // to be able to report test failures.
                sh 'go test -v ./... 2>&1 | /root/go/bin/go-junit-report > report.xml || true'
                // Archive test report.
                junit skipPublishingChecks: true, testResults: 'report.xml'
                // Generate coverage info.
                sh 'go test -covermode=count -coverprofile=count.out fmt'
                sh 'go tool cover -func=count.out'
                // Generate an HTML report from it.
                sh 'go tool cover -html=count.out -o cover.html'
                // Archive this report.
                publishHTML target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: false,
                    reportDir: '.',
                    reportFiles: 'cover.html',
                    reportName: 'Coverage Report'
                ]
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