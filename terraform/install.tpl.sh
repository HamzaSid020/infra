#!/bin/bash

echo "Updating package list and installing prerequisites..."
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "Adding Docker's repository to APT sources..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating package list..."
sudo apt update

echo "Installing Docker..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Verifying Docker installation..."
docker --version

echo "Adding current user to Docker group (optional)..."
sudo usermod -aG docker $USER

echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Verifying Docker Compose installation..."
docker-compose --version

echo "Installation completed successfully!"

mkdir maverics
cd maverics
git clone -b dev --recurse-submodules https://github.com/Maverics-Seneca/Capstone-Project.git .
git submodule init
git submodule foreach 'git fetch && git checkout dev && git pull origin dev'

# Write directly to the .env file using HEREDOC
cat >.env <<EOF
JWT_SECRET=${jwt_secret}
RESEND_API_KEY=${resend_api}
FIREBASE_CREDENTIALS=${firebase_creds}
EOF
echo "Created .env file in main directory."

sudo docker login mavericacr.azurecr.io -u MavericACR -p ACRPassword

sudo docker-compose up