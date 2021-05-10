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
  
  heisln.user.service:
    image: deitsch/heisln-userservice
    container_name: heisln-userservice
    ports:
      - 9001:80
    networks:
      - heisln-net
    depends_on:
      - mongo

  mongo:
    image: mongo
    container_name: mongo
    ports:
      - 27017:27017
    networks:
      - heisln-net

  heisln-carrental-service:
    image: deitsch/heisln-carrentalservice
    container_name: heisln-carrentalservice
    ports:
      - 9002:80
    depends_on:
      - heisln-mysql
    networks:
      - heisln-net

  db:
    container_name: heisln-mysql
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
  
  rabbitmq:
    image: deitsch/rabbitmq
    container_name: rabbitmq
    ports:
      - 15672:15672
      - 5672:5672
    networks:
      - heisln-net
    environment:
      - RABBITMQ_USER=test
      - RABBITMQ_PASSWORD=test
      - RABBITMQ_USER1=test1
      - RABBITMQ_PASSWORD1=test1

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