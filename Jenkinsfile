podTemplate(label: 'mypod', containers: [
    containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.8.0', command: 'cat', ttyEnabled: true),
    containerTemplate(name: 'helm', image: 'lachlanevenson/k8s-helm:latest', command: 'cat', ttyEnabled: true)
  ]) {
    node('mypod') {

        def docEnv = "\$(minikube docker-env)"   
        def mvnHome = tool 'M3'
        stage ("Checkout Source"){

            checkout scm

            env.DOCKER_API_VERSION="1.23"

            appName = "sample-demo"
            imageName = "${appName}:latest"
            env.BUILDIMG=imageName
        } 

        // stage ("Build war"){
            
        //     echo "Building version"
            
        //     sh "${mvnHome}/bin/mvn clean package"
        // }

        // stage ("Unit Tests"){

        //     echo "Unit Tests"
        //     sh "${mvnHome}/bin/mvn test"
        // }
        stage('do some kubectl work') {
            container('kubectl') {

                sh "kubectl get nodes"
            }
        }

        stage ("Docker Build"){
        
            sh "eval ${docEnv}"
            sh "docker build -t ${imageName} ."
        }

        stage ("Docker Deploy"){

            sh "kubectl create -f  deploy.yml"
        }
    }
}
