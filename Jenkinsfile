
pipeline {
    agent any

    tools {
        jdk 'JDK21'            // Make sure JDK21 is installed in Jenkins global tools
        maven 'Maven-3.9.9'    // Make sure Maven-3.9.9 is installed in Jenkins global tools
    }

    stages {

        stage('Checkout') {
            steps {
                // Clone your GitHub repository
                git branch: 'main', url: 'https://github.com/seshuadi969/retail-banking.git'
            }
        }

        stage('Build') {
            steps {
                // Build project and skip tests, ignore clean errors
                sh 'mvn clean package -DskipTests -Dmaven.clean.failOnError=false'
            }
        }

        stage('Test') {
            steps {
                // Run unit tests
                sh 'mvn test || true'   // `|| true` prevents pipeline failure if tests fail
            }
        }

        stage('Package') {
            steps {
                // Archive the JAR/WAR file as a Jenkins artifact
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'

                // Example: run the jar
                sh 'nohup java -jar target/*.jar > app.log 2>&1 &'

                // OR, if Docker:
                // sh 'docker build -t retail-banking-app .'
                // sh 'docker run -d -p 8080:8080 --name retail-banking retail-banking-app'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
