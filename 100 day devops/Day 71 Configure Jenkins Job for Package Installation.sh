pipeline {
    agent any
    parameters {
        string(name: 'PACKAGE', defaultValue: '', description: 'Package to install (e.g., vim)')
    }
    stages {
        stage('Install') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'ssh-storage-cred', usernameVariable: 'SSH_USER', passwordVariable: 'SSH_PASS')]) {
                    sh '''
                    sshpass -p "$SSH_PASS" ssh -o StrictHostKeyChecking=no "$SSH_USER"@ststor01 "echo \\"$SSH_PASS\\" | sudo -S yum install -y ${PACKAGE} || echo \\"$SSH_PASS\\" | sudo -S apt-get install -y ${PACKAGE}"
                    '''
                }
            }
        }
    }
    post {
        success { echo "Installed ${params.PACKAGE} successfully!" }
        failure { echo "Failed - check logs." }
    }
}