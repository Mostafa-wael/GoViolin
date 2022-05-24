pipeline {
    agent any
    environment{
        REPO_URL = 'https://github.com/Rosalita/GoViolin'
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
                sh 'docker build -t insta .'
            }
            post {
                  always
                    {
                        echo 'Finished..'
                    }
            }
        }
    }
}