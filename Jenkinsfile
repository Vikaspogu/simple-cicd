node {
    echo "In Jenkinsfile"
    stage "Checkout Source" 
    
        checkout scm
    
    stage "Build war" 

        echo "Building version ${version}"

        sh "mvn clean package -DskipTests"
    
    stage "Unit Tests" 

        echo "Unit Tests"
        sh "mvn test"
    
    stage "Run war" 

        echo "Run war"
        sh "java -jar target/demo-0.0.1-SNAPSHOT.jar"
    
}