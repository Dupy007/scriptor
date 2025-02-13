#!/bin/bash
# Script d'installation automatisée
#
if [ "$EUID" -ne 0 ]; then
  echo "Veuillez exécuter ce script avec les privilèges root (sudo)."
  exit 1
fi

echo "===== Mise à jour des dépôts et upgrade des paquets ====="
apt update && apt upgrade -y

echo "===== Installation de Nmap ====="
apt install -y nmap

echo "===== Installation d'OpenSSH Server (incluant SFTP) ====="
apt install -y openssh-server

echo "===== Installation d'OpenSSH Client (pour le client SFTP) ====="
apt install -y openssh-client


echo "===== Vérification et configuration de SFTP ====="
# Vérifier si le subsystem SFTP est déjà défini dans la configuration SSH
if grep -q "Subsystem sftp" /etc/ssh/sshd_config; then
    echo "La configuration SFTP existe déjà dans /etc/ssh/sshd_config."
else
    echo "Ajout de la configuration SFTP dans /etc/ssh/sshd_config..."
    echo "Subsystem sftp /usr/lib/openssh/sftp-server" >> /etc/ssh/sshd_config
fi

echo "===== Redémarrage du service SSH ====="
systemctl restart ssh
