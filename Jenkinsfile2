pipeline{
    agent any
    tools {
        maven 'maven'
    }
    stages {
        stage('Pull Source Code from Github'){
            steps{
               git branch: 'main',
               credentialsId: 'ba24d4fc-03fb-4241-b75c-f34f7c9d1cb5',
               url: 'https://github.com/Daicon001/Application.git'
               
            }
        }
        stage('Code Analysis'){
            steps{
                withSonarQubeEnv('sonarQube') {
                    sh "mvn sonar:sonar"
                }
            }
        }
        stage('Building Source Code') {
            steps{
               sh 'mvn package -Dmaven.test.skip'
            }
        }
        stage('Sending Artifacts') {
            steps{
                sshagent(['jenkinskey']) {
                sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/petadoption/target/spring-petclinic-2.4.2.war ec2-user@52.26.44.115:/opt/docker'
                }
             }
        }
    }
}
