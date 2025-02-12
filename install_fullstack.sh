#!/bin/bash
# Script d'installation automatisée pour un environnement fullstack developer sur Debian/Ubuntu
#
# Ce script installe :
# - MySQL
# - PHP 7.4-FPM
# - OpenJDK 17 et (optionnellement) OpenJDK 21
# - Python3 et pip
# - Apache2
# - Node.js et npm
# - Docker et LazyDocker
# - Maven (mvn)
# - Bind9 (serveur DNS)
# - OpenSSH Server (SSH)
# - Nmap (outil de scan réseau)
# - Et divers outils supplémentaires utiles pour le développement (Git, build-essential, vim, etc.)

# Vérification que le script est exécuté en root
if [ "$EUID" -ne 0 ]; then
  echo "Veuillez exécuter ce script avec les privilèges root (sudo)."
  exit 1
fi

echo "===== Mise à jour des dépôts et upgrade des paquets ====="
apt update && apt upgrade -y

echo "===== Installation des outils de base ====="
# Outils essentiels pour le développement
apt install -y git build-essential curl vim unzip htop net-tools tree

echo "===== Installation de MySQL ====="
apt install -y mysql-server

echo "===== Installation de PHP 7.4-FPM ====="
apt install -y php7.4-fpm
# Remarque : Si PHP 7.4 n'est pas présent, pensez à ajouter le dépôt ondrej/php ou à choisir une autre version.

echo "===== Installation d'OpenJDK 17 ====="
apt install -y openjdk-17-jdk

echo "===== Installation d'OpenJDK 21 ====="
if apt-cache show openjdk-21-jdk > /dev/null 2>&1; then
    apt install -y openjdk-21-jdk
else
    echo "Le paquet openjdk-21-jdk n'est pas disponible dans les dépôts officiels."
    echo "Pour installer Java 21, envisagez d'ajouter un PPA ou d'utiliser SDKMAN."
    # Exemple d'ajout d'un PPA (à décommenter si nécessaire) :
    # add-apt-repository ppa:openjdk-r/ppa -y
    # apt update
    # apt install -y openjdk-21-jdk
fi

echo "===== Installation de Python3 et pip ====="
apt install -y python3 python3-pip

echo "===== Installation d'Apache2 ====="
apt install -y apache2

echo "===== Installation de Node.js et npm ====="
# Utilisation du script officiel NodeSource pour installer Node.js (ici version 18.x)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

echo "===== Installation de Docker ====="
# Suppression des anciennes versions de Docker, si présentes
apt remove -y docker docker-engine docker.io containerd runc || true

# Installation des paquets nécessaires pour un dépôt sécurisé
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Ajout de la clé GPG officielle de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Ajout du dépôt Docker aux sources APT
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io

echo "===== Installation de LazyDocker via Snap ====="
# Si snapd n'est pas installé, il sera installé
apt install -y snapd
snap install lazydocker

echo "===== Installation de Maven (mvn) ====="
apt install -y maven

echo "===== Installation de Bind9 (serveur DNS) ====="
apt install -y bind9 bind9utils bind9-doc

echo "===== Installation d'OpenSSH Server (SSH) ====="
apt install -y openssh-server

echo "===== Installation de Nmap ====="
apt install -y nmap

echo "===== Nettoyage final ====="
apt autoremove -y

echo "===== Installation terminée avec succès ! ====="
