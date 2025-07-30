pipeline {
    agent any

    tools {
        sonarQubeScanner 'sonar-scanner'
    }

    environment {
        SONAR_PROJECT_KEY = 'quality-gate-demo' // Change this if needed
    }

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/UTSAV271223/quality-gate-cicd-pipeline.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube-local') {
                    sh 'sonar-scanner -Dsonar.projectKey=$SONAR_PROJECT_KEY -Dsonar.sources=. -Dsonar.host.url=http://localhost:9000'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t quality-gate-app .'
            }
        }

        stage('Docker Run') {
            steps {
                sh 'docker run -d -p 3000:3000 quality-gate-app'
            }
        }
    }
}
