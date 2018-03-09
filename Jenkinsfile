node {
    
    def mvnHome = tool 'maven-3'
    def docker-env = "$(minikube docker-env)"

    stage "Checkout Source" 

        checkout scm

        env.DOCKER_API_VERSION="1.23"

        appName = "sample-demo"
        imageName = "${appName}:latest"
        env.BUILDIMG=imageName
    
    stage "Build war" 

        echo "Building version"

        sh "${mvnHome}/bin/mvn clean package -DskipTests"
    
    stage "Unit Tests" 

        echo "Unit Tests"
        sh "${mvnHome}/bin/mvn test"
    
    stage "Docker Build"
    
        sh "eval ${docker-env}"
        sh "docker build -t ${imageName} ."

    stage "Docker Deploy"

        sh "kubectl create -f  deploy.yml"
    
}