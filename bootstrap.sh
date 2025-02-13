#!/bin/bash
# bootstrap.sh
# Ce script sert à télécharger et lancer les installations automatisées depuis un repository Git.
#
# Il vérifie d'abord si Git est installé (et l’installe si besoin),
# clone (ou met à jour) le repository contenant les scripts d'installation,
# puis demande à l'utilisateur s'il souhaite installer toutes les dépendances en une fois
# ou les valider individuellement (chaque dépendance étant dans un sous-dossier avec un install.sh).

# ---------------------------
# Configuration
# ---------------------------
REPO_URL="https://github.com/Dupy007/scriptor.git"  # Remplacez par l'URL de votre repo
REPO_DIR="scriptor"  # Nom du dossier créé après le clonage

# ---------------------------
# Fonctions
# ---------------------------

# Vérifie si Git est installé, sinon l'installe
install_essentiels() {
    echo "===== Mise à jour des dépôts et upgrade des paquets ====="
    apt update && apt upgrade -y
    echo "===== Installation des outils de base ====="
# Outils essentiels pour le développement
    apt install -y git build-essential curl vim unzip htop net-tools tree

}

# Clone ou met à jour le repository
clone_repository() {
    if [ ! -d "$REPO_DIR" ]; then
        echo "Clonage du repository depuis $REPO_URL ..."
        git clone "$REPO_URL" "$REPO_DIR"
    else
        echo "Le repository existe déjà dans le dossier '$REPO_DIR'."
        read -p "Voulez-vous mettre à jour le repository ? (y/n): " update_repo
        if [ "$update_repo" == "y" ]; then
            cd "$REPO_DIR" || exit
            git pull
            cd ..
        fi
    fi
}

# Parcourt les sous-dossiers du repository et lance les scripts d'installation
# selon le mode choisi : "all" pour tout installer sans confirmation,
# "individual" pour demander pour chaque sous-dossier.
run_install_scripts() {
    local mode="$1"  # "all" ou "individual"
    for dir in "$REPO_DIR"/*/ ; do
        # On retire la barre oblique finale et on récupère le nom du dossier
        dir="${dir%/}"
        if [ -f "$dir/install.sh" ]; then
            if [ "$mode" == "all" ]; then
                echo "Lancement de l'installation pour $(basename "$dir")..."
                bash "$dir/install.sh"
            else
                echo "--------------------------------------------------"
                echo "Dépendance : $(basename "$dir")"
                echo "Description (extrait du script d'installation) :"
                # Affiche les premières lignes commentées (supposées décrire l'installation)
                grep '^#' "$dir/install.sh" | head -n 5
                read -p "Voulez-vous installer cette dépendance ? (y/n): " answer
                if [ "$answer" == "y" ]; then
                    echo "Lancement de l'installation pour $(basename "$dir")..."
                    bash "$dir/install.sh"
                else
                    echo "Installation pour $(basename "$dir") ignorée."
                fi
            fi
        fi
    done
}

# ---------------------------
# Script Principal
# ---------------------------
echo "===== Démarrage du script Bootstrap d'automatisation ====="

# 1. Vérifier et installer Git si nécessaire
install_essentiels

# 2. Cloner ou mettre à jour le repository
clone_repository

# 3. Demander à l'utilisateur s'il souhaite installer toutes les dépendances
read -p "Voulez-vous installer toutes les dépendances automatiquement ? (y/n): " install_all

if [ "$install_all" == "y" ]; then
    run_install_scripts "all"
else
    run_install_scripts "individual"
fi

echo "===== Nettoyage final ====="
apt autoremove -y

echo "===== Installation terminée avec succès ! ====="

echo "===== Fin du script Bootstrap ====="
