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
        stage('Docker Build') {
          when {
              expression { params.BRANCH == 'develop' }
            }
          steps {
            withCredentials([usernamePassword(credentialsId: 'nexus', usernameVariable: 'username', passwordVariable: 'password')]) {
                DockerBuild(BUILD_NUMBER, username, password)
            }
          }
        }
    }
}
