# Script d'installation

Ce script Bash installe un ensemble complet d'outils et de services pour préparer un environnement de développement ou production sur une distribution Debian/Ubuntu. Il s'adresse notamment aux développeurs souhaitant disposer d'un environnement prêt à l'emploi avec des composants pour le développement web, Java, Python, Node.js, ainsi que divers outils réseau et de conteneurisation.

## Fonctionnalités

Le script installe et configure les éléments suivants :

- **Mise à jour du système** : `apt update` et `apt upgrade`
- **Outils de base** :  
  - `git`, `build-essential`, `curl`, `vim`, `unzip`, `htop`, `net-tools`, `tree`
- **Bases de données et serveurs web** :  
  - **MySQL**  
  - **Apache2**
- **PHP** :  
  - PHP 7.4-FPM  
  > *Remarque : Sur certaines versions récentes d'Ubuntu (ex. 22.04), PHP 7.4 n'est pas disponible par défaut. Vous pouvez ajouter le dépôt [ondrej/php](https://launchpad.net/~ondrej/+archive/ubuntu/php) ou adapter la version de PHP souhaitée.*
- **Java** :  
  - OpenJDK 17  
  - OpenJDK 21 (installation conditionnelle selon la disponibilité dans les dépôts)  
- **Python** :  
  - Python3 et pip
- **Node.js et npm** 
- **Docker**
- **LazyDocker** 
- **Maven** :  
  - Outil de gestion et de compilation pour les projets Java
- **Bind9** :  
  - Serveur DNS (avec bind9utils et bind9-doc)
- **SSH** :  
  - OpenSSH Server pour la gestion des connexions sécurisées
- **Nmap** :  
  - Outil de scan réseau

## Prérequis

- **Système d'exploitation** : Debian, Ubuntu ou dérivés.
- **Privilèges** : Le script doit être exécuté en tant que root ou avec `sudo`.
- **Outils requis :** : `curl` ou `wget` pour télécharger le script.  
- **Accès Internet** pour récupérer le fichier depuis GitHub.

# Installation du script Bootstrap

Ce guide vous explique comment télécharger et exécuter le script `bootstrap.sh` hébergé sur GitHub. Ce script permet de cloner et de lancer l'installation des différentes dépendances nécessaires.


## Téléchargement du script

Pour télécharger le fichier `bootstrap.sh`, vous pouvez utiliser l'une des commandes suivantes :

### Avec `curl`

```bash
curl -o bootstrap.sh https://raw.githubusercontent.com/Dupy007/scriptor/main/bootstrap.sh
```

### Avec `wget`

```bash
wget -O bootstrap.sh https://raw.githubusercontent.com/Dupy007/scriptor/main/bootstrap.sh
```

## Rendre le script exécutable
```bash
sudo chmod +x bootstrap.sh
```

## Exécution du script
```bash
sudo ./bootstrap.sh
```

## Remarques

- **Adaptation** :  
  Ce script est fourni "tel quel". Il est recommandé de le tester dans un environnement de développement ou de test avant de l'utiliser en production.

- **Dépôts et versions** :  
  Certaines versions de logiciels (comme PHP 7.4 ou OpenJDK 21) peuvent nécessiter l'ajout de dépôts supplémentaires ou des ajustements en fonction de la version de votre système d'exploitation.


## Licence

Vous pouvez utiliser et modifier ce script librement pour vos besoins personnels ou professionnels.

## Auteur

Ce script a été généré et adapté à partir des besoins d'un environnement de développement fullstack.

---

N'hésitez pas à adapter ce README et le script en fonction de vos besoins spécifiques ou des particularités de votre environnement.
