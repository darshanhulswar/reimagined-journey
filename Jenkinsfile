pipeline{
    agent any
    stages{
        stage('Build & Test'){
            stages{
                stage('Compile'){
                    steps{
                        echo "hello this is compiling"
                    }
                }
                stage('Unit testing'){
                    steps{
                        echo "Running unit tests..."
                    }
                }

            }
        }

        stage('Deploy'){
            steps{
                echo "deployed...."
            }
        }

    }
}

