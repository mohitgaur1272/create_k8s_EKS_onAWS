#!/bin/bash

# Create the install script
sudo touch /tmp/install_apache_docker_jenkins.sh

# Write the installation commands into the script
echo '#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt-get update -y

# Install Apache2
echo "Installing Apache2..."
sudo apt-get install -y apache2

# Start Apache2 service and enable it to start on boot
echo "Starting Apache2 service..."
sudo systemctl start apache2
sudo systemctl enable apache2

# Install Docker
echo "Installing Docker..."
sudo apt-get install -y docker.io

# Adjust permissions for Docker socket
echo "Adjusting Docker socket permissions..."
sudo chmod 666 /var/run/docker.sock

# Add user to the docker group
echo "Adding user ubuntu to the docker group..."
sudo usermod -aG docker ubuntu

# Install OpenJDK 17 (updated from OpenJDK 11)
echo "Installing OpenJDK 17..."
sudo apt-get install -y openjdk-17-jdk

# Set OpenJDK 17 as the default version
echo "Setting OpenJDK 17 as the default version..."
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-17-openjdk-amd64/bin/java 1
sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java

# Verify Java version
java -version

# Add Jenkins GPG key and repository
echo "Adding Jenkins GPG key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install Jenkins
echo "Installing Jenkins..."
sudo apt install -y jenkins

# Configure Jenkins to use Java 17
echo "Configuring Jenkins to use Java 17..."
sudo sed -i "s|^JAVA_HOME=.*|JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64|" /etc/default/jenkins

# Start Jenkins service and enable it to start on boot
echo "Starting Jenkins service..."
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Display Jenkins initial admin password
echo "Jenkins setup complete. Fetching initial admin password..."
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
' > /tmp/install_apache_docker_jenkins.sh

# Set correct permissions for the install script
echo "Setting permissions for the install script..."
sudo chmod +x /tmp/install_apache_docker_jenkins.sh

# Run the installation script
echo "Running the installation script..."
sudo /tmp/install_apache_docker_jenkins.sh
