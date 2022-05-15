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
         stage ('Deploy') {
            steps {
                sh """
                kubectl get ns --kubeconfig /tmp/config

              """ 
	    }          
        }
    }
}
