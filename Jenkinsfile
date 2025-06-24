pipeline {
    agent any

    environment {
        IMAGE_NAME = "local/app"
        IMAGE_TAG = "v1"
        IMAGE_FILE = "app_image.tar"
        REMOTE_USER = "ubuntu"
        REMOTE_HOST = "your.server.ip"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/your-user/your-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Save Docker Image as Tar') {
            steps {
                sh "docker save ${IMAGE_NAME}:${IMAGE_TAG} > /tmp/${IMAGE_FILE}"
            }
        }

        stage('Copy Image to Remote') {
            steps {
                sh "scp /tmp/${IMAGE_FILE} ${REMOTE_USER}@${REMOTE_HOST}:/tmp/"
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh "ansible-playbook ansible/deploy.yml -i ${REMOTE_HOST}, -u ${REMOTE_USER} --private-key ~/.ssh/id_rsa"
            }
        }
    }
}

