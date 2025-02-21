#!/bin/bash
# Script d'installation automatisée 
#
if [ "$EUID" -ne 0 ]; then
  echo "Veuillez exécuter ce script avec les privilèges root (sudo)."
  exit 1
fi

echo "===== Mise à jour des dépôts et upgrade des paquets ====="
apt update && apt upgrade -y


echo "===== Installation d'Apache2 ====="
apt install -y apache2

cp createvhost /usr/local/bin/
chmod +X /usr/local/bin/createvhost

cp phpw /usr/local/bin/
chmod +X /usr/local/bin/phpw

echo "===== Installation de Bind9 (serveur DNS) ====="
apt install -y bind9 bind9utils bind9-doc

# Installation des paquets nécessaires pour un dépôt sécurisé
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

echo "===== Installation de Certbot (Certificat ssl) ====="
sudo snap install certbot --classic