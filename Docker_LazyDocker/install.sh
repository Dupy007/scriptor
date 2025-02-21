#!/bin/bash
# Script d'installation automatisée
#
if [ "$EUID" -ne 0 ]; then
  echo "Veuillez exécuter ce script avec les privilèges root (sudo)."
  exit 1
fi

echo "===== Mise à jour des dépôts et upgrade des paquets ====="
apt update && apt upgrade -y

# Ajout du dépôt Docker aux sources APT
snap install docker 
chmod 777 /var/run/docker.sock


echo "===== Installation de LazyDocker ====="
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
ln -s $HOME/.local/bin/lazydocker /usr/local/bin/