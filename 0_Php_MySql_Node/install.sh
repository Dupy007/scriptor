#!/bin/bash
# Script d'installation automatisée
#
if [ "$EUID" -ne 0 ]; then
  echo "Veuillez exécuter ce script avec les privilèges root (sudo)."
  exit 1
fi

echo "===== Mise à jour des dépôts et upgrade des paquets ====="
apt update && apt upgrade -y


echo "===== Installation de MySQL ====="
apt install -y mysql-server

cp createdbuser /usr/local/bin/
chmod +X /usr/local/bin/createdbuser

echo "===== Installation de PHP ====="
apt install -y php

echo "===== Installation de Node.js ====="
sudo snap install node --classic --channel=edge
sudo apt -y install npm
