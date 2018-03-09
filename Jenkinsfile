node {

    def docEnv = "\$(minikube docker-env)"
    tools {
        maven 'M3'   
    }    
    
    stage ("Checkout Source"){

        checkout scm

        env.DOCKER_API_VERSION="1.23"

        appName = "sample-demo"
        imageName = "${appName}:latest"
        env.BUILDIMG=imageName
    } 

    stage ("Build war"){

        echo "Building version"
    
        sh "mvn clean package -DskipTests"
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
