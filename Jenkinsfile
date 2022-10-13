pipeline{
    agent any
    environment {
        DOCKER_USER     = credentials('dockerUsername')
        DOCKER_PASSWORD = credentials('dockerPwd')
    }
    stages {
        stage('Code Analysis'){
            steps{
                withSonarQubeEnv('sonarQube') {
                    sh "mvn sonar:sonar"
                }
            }
        }
        stage('BuildCode'){
            steps{

               sh 'mvn install -DskipTests=true'
            }
        }
        stage('DockerBuild'){
            steps{
                sh 'bash && docker build -t daicon001/pipeline:1.0.11 .'
            }
        }
        stage('DockerLogin') {
            steps{
                sh 'docker login --username $DOCKER_USER --password $DOCKER_PASSWORD'
            }
        }
        stage('DockerPush') {
            steps{
                sh 'docker push daicon001/pipeline:1.0.11'
            }
        }
        stage('Deploy') {
             steps {
               sshagent (['ansible_creds']) {
                   sh 'ssh -t -t ec2-user@52.41.154.250 -o strictHostKeyChecking=no "cd /etc/ansible && ansible-playbook /opt/auto-discovery/run.yml"'
                }
            }
        }
    }
}
