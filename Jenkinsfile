node {

    def docEnv = "\$(minikube docker-env)"   
    
    stage ("Checkout Source"){

        checkout scm

        env.DOCKER_API_VERSION="1.23"

        appName = "sample-demo"
        imageName = "${appName}:latest"
        env.BUILDIMG=imageName
    } 

    stage ("Build war"){
        env.PATH = "${tool 'M3'}/bin:${env.PATH}"
        echo "Building version"
        echo "mvn -version"
        sh "mvn clean package"
    }

    stage ("Unit Tests"){

        echo "Unit Tests"
        sh "mvn test"
    }

    stage ("Docker Build"){
    
        sh "eval ${docEnv}"
        sh "docker build -t ${imageName} ."
    }

    stage ("Docker Deploy"){

        sh "kubectl create -f  deploy.yml"
    }
}
