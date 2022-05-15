pipeline {
    agent any

    environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
        SHORT_COMMIT = "${GIT_COMMIT[0..7]}"
	}
    stages {
        stage('Docker Login') {
            steps {
                // Add --password-stdin to run docker login command non-interactively
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Build & push Dockerfile') {
            steps {
                
                sh 'ansible-playbook ansible-playbook.yml --extra-vars tag="$SHORT_COMMIT"'
                
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([[
                  $class: 'AmazonWebServicesCredentialsBinding',
                  credentialsId: "aws-credentials",
                  accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                  secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                  ]]) {
                  sh """
                  who
                  kubectl -n comingsoon apply -f service.yaml
                  kubectl -n comingsoon apply -f deployment.yaml
                  """
                }
            }
    }
    }
}
