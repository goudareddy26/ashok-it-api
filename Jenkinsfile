pipeline {
  agent any

  environment {
    KUBECONFIG = '/var/lib/jenkins/.kube/config'
  }

  stages {
    // Stage 1: Checkout Repository
    stage('Checkout Repository') {
      steps {
        echo 'Checking out GitHub repository...'
        git branch: 'main', url: 'https://github.com/goudareddy26/ashok-it-api.git'
      }
    }

    // Stage 2: Check Jenkins-Minicube connectivity
    stage('Cluster Info') {
      steps {
        echo 'Showing cluster context and nodes...'
        sh '''
          bash -lc '
          set -euo pipefail
          kubectl config current-context
          kubectl get nodes -o wide
          '
        '''
      }
	 
	 
  post {
    success { echo '✅ Cluster info retrieved successfully' }
    failure { echo '❌ Failed to retrieve cluster info' }
    }
    
 }

 // Stage 3: Apply RBAC rules
       stage('Apply RBAC Rules') {
      steps {
        echo 'Applying RBAC YAMLs...'
        sh '''
          kubectl apply -f k8s-rbac/service-account.yaml
          kubectl apply -f k8s-rbac/role.yaml
          kubectl apply -f k8s-rbac/rolebinding.yaml
        '''
      }
    } 
	
// stage 4 'Deploy Application' 
stage('Deploy Application'){ 
  steps {
    echo 'Deploying Spring Boot App...'
    sh '''
      bash -lc '
      kubectl apply -f springboot-app.yaml
      kubectl get pods -n ashokit
      '
    '''
   }
  }	
  }
}
