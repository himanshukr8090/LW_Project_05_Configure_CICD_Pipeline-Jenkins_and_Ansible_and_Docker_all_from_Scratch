pipeline {
    agent any

    environment {
        IMAGE_NAME = "local/webapp"
        IMAGE_TAG = "v1"
        IMAGE_FILE = "webapp.tar"
        REMOTE_USER = "ec2-user"
        REMOTE_HOST = "13.233.159.43"
        PEM_PATH = "/var/lib/jenkins/.ssh/LW-Projects.pem"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/himanshukr8090/LW_Project_05_Configure_CICD_Pipeline-Jenkins_and_Ansible_and_Docker_all_from_Scratch.git'
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
                sh """
                    scp -i ${PEM_PATH} -o StrictHostKeyChecking=no /tmp/${IMAGE_FILE} ${REMOTE_USER}@${REMOTE_HOST}:/tmp/
                """
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh """
                    ansible-playbook ansiblefile.yml -i ${REMOTE_HOST}, -u ${REMOTE_USER} \
                    --private-key ${PEM_PATH} --ssh-extra-args='-o StrictHostKeyChecking=no'
                """
            }
        }
    }
}

