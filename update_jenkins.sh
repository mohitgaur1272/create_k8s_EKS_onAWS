#!/bin/bash

# Function to check if the previous command executed successfully
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error occurred during $1. Exiting."
    exit 1
  fi
}

# Step 1: Update package list
echo "Updating package list..."
sudo apt-get update -y
check_success "apt-get update"

# Step 2: Install Apache2
echo "Installing Apache2..."
sudo apt-get install -y apache2
check_success "Apache2 installation"

# Start Apache2 service and enable it to start on boot
echo "Starting Apache2 service..."
sudo systemctl start apache2
sudo systemctl enable apache2
check_success "Apache2 service start"

# Step 3: Install Docker
echo "Installing Docker..."
sudo apt-get install -y docker.io
check_success "Docker installation"

# Start Docker service and enable it to start on boot
sudo systemctl start docker
sudo systemctl enable docker
check_success "Docker service start"

# Adjust permissions for Docker socket
echo "Adjusting permissions for Docker socket..."
sudo chmod 666 /var/run/docker.sock

# Add the current user to the Docker group
echo "Adding $USER to the Docker group..."
sudo usermod -aG docker $USER

# Step 4: Install OpenJDK 17
echo "Installing OpenJDK 17..."
sudo apt install -y openjdk-17-jdk
check_success "OpenJDK 17 installation"

# Step 5: Configure Java 17 as the default version
echo "Configuring OpenJDK 17 as the default version..."
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-17-openjdk-amd64/bin/java 1
sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java
check_success "Setting Java 17 as default"

# Verify Java version
java -version

# Step 6: Install Jenkins
# Add Jenkins GPG key and repository
echo "Adding Jenkins GPG key and repository..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
check_success "Adding Jenkins GPG key"

echo "Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
check_success "Adding Jenkins repository"

# Update package list after adding Jenkins repository
echo "Updating package list..."
sudo apt update -y
check_success "apt update after adding Jenkins repo"

# Install Jenkins
echo "Installing Jenkins..."
sudo apt install -y jenkins
check_success "Jenkins installation"

# Step 7: Configure Jenkins to use Java 17
echo "Configuring Jenkins to use Java 17..."
sudo sed -i 's|^JAVA_HOME=.*|JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64|' /etc/default/jenkins

# Start Jenkins service and enable it to start on boot
echo "Starting Jenkins service..."
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins
check_success "Jenkins service start"

# Step 8: Display installation status
echo "Installation completed successfully!"
echo "Apache, Docker, and Jenkins are installed and running."
echo "To access Jenkins, visit: http://<your-server-ip>:8080"

# Display initial Jenkins admin password
echo "Fetching Jenkins initial admin password..."
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
