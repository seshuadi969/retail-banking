pipeline {
    agent any

    tools {
        maven 'Maven-3.9.11'   // Use the Maven you configured in Jenkins (Manage Jenkins → Tools)
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/seshuadi969/retail-banking.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                sh 'java -jar target/*.jar &'
            }
        }
    }
}

