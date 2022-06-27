@Library("jenkins-shared-library@kaiburr") _
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
              deleteDir()
              echo "Checking out....."
              checkout scm
            }
        }
        stage('Build App') {
            when {
                expression { params.BRANCH != 'develop' }
            }         
            steps {
                goBuild()
            }
        }
    }
}
