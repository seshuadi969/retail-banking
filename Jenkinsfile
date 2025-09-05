
pipeline {
    agent any

    tools {
        jdk 'JDK21'                // Must match the JDK you configured in Jenkins
        maven 'Maven-3.9.9'        // Must match Maven name configured in Jenkins
    }

    environment {
        IMAGE_NAME = "retail-banking-app"
        CONTAINER_NAME = "retail-banking-container"
        WORKDIR = "/var/lib/jenkins/workspace/banking application"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/seshuadi969/retail-banking.git'
            }
        }

        stage('Build') {
            steps {
                // Avoid clean delete issue + handle space in path
                sh 'cd "$WORKDIR" && mvn package -DskipTests -Dmaven.clean.failOnError=false'
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    cd "$WORKDIR"
                    docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    # Stop old container if running
                    docker rm -f $CONTAINER_NAME || true
                    
                    # Run new container
                    docker run -d --name $CONTAINER_NAME -p 8080:8080 $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful! App is running at http://<server-ip>:8080'
        }
        failure {
            echo '❌ Build/Deploy failed. Check logs.'
        }
    }
}

      
