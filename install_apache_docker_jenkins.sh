#!/bin/bash


sudo touch /tmp/install_apache_docker_jenkins.sh

echo '#!/bin/bash

# Update package list
sudo apt-get update

# Install Apache2
sudo apt-get install -y apache2

# Start Apache2 service and enable it to start on boot
sudo systemctl start apache2
sudo systemctl enable apache2

# Install Docker
sudo apt-get install -y docker.io

# Adjust permissions for Docker socket
sudo chmod 777 /var/run/docker.sock

# Add user to the docker group
sudo usermod -aG docker ubuntu

# Install OpenJDK 11
sudo apt update -y
sudo apt install openjdk-11-jdk -y

# Add Jenkins GPG key ,# Add Jenkins repository
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
	  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
	  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
	    /etc/apt/sources.list.d/jenkins.list > /dev/null


# Update package list
sudo apt update -y

# Install Jenkins
sudo apt install jenkins -y

# Start Jenkins service and enable it to start on boot
sudo systemctl start jenkins
sudo systemctl enable jenkins' > /tmp/install_apache_docker_jenkins.sh

sudo chmod +x /tmp/install_apache_docker_jenkins.sh
sudo /tmp/install_apache_docker_jenkins.sh
