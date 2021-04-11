#!/bin/bash

# Script to deploy the car-rental application

# Exit immediatelly on failure
set -e

# Run in non-interactive mode -> apt will use default values and not ask questions
export DEBIAN_FRONTEND=noninteractive

# Install Docker (https://docs.docker.com/engine/install/ubuntu/)
# -y -> answer yes to everything
apt-get update
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

apt-key fingerprint 0EBFCD88
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

## Install Docker Compose (https://docs.docker.com/compose/install/)
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# create docker network
docker network create heisln-net

# create docker-compose.yml on instance
echo """
version: '3.5'

services:
  heisln-frontend:
    container_name: heisln-frontend
    image: deitsch/heisln-frontend
    ports:
      - 8100:80
    networks:
      - heisln-net

  heisln-api:
    container_name: heisln-api
    image: deitsch/heisln-api
    ports:
      - 8000:80
    networks: 
      - heisln-net
    depends_on:
      - heisln-db

  heisln-db:
    container_name: heisln-db
    image: mysql:8.0.23
    ports:
        - 3306:3306
    networks: 
      - heisln-net
    environment:
        MYSQL_ROOT_PASSWORD: qwertzuio
        MYSQL_USER: test
        MYSQL_PASSWORD: pass@word1234
        MYSQL_DATABASE: Heisln.Car.Db

  heisln-currency-converter:
    container_name: 'heisln-currency-converter'
    image: 'deitsch/heisln-currency-converter'
    ports:
      - 9000:80
    networks:
      - heisln-net

networks:
  heisln-net:
    external: true
""" >> /srv/docker-compose.yml

# Run containers
docker-compose -f /srv/docker-compose.yml up -d