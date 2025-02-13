#!/bin/bash
# Script d'installation automatisée 
#
if [ "$EUID" -ne 0 ]; then
  echo "Veuillez exécuter ce script avec les privilèges root (sudo)."
  exit 1
fi

echo "===== Mise à jour des dépôts et upgrade des paquets ====="
apt update && apt upgrade -y


echo "===== Installation d'OpenJDK 17 ====="
apt install -y openjdk-17-jdk openjdk-17-jre

echo "===== Installation d'OpenJDK 21 ====="
apt install -y openjdk-21-jdk openjdk-21-jre

echo "===== Installation de Maven (mvn) ====="
apt install -y maven

echo "===== Installation de Python3 et pip ====="
apt install -y python3 python3-pip