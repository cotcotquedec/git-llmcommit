#!/bin/bash

# Script d'installation pour LLMCommit

# Variables
INSTALL_DIR="$HOME/bin"
SCRIPT_NAME="git-llmcommit"
GITHUB_USER="cotcotquedec"  # Remplacez par votre nom d'utilisateur GitHub si différent
GITHUB_REPO="git-llmcommit"
BRANCH="main"  # Assurez-vous que la branche est correcte (main ou master)
SCRIPT_URL="https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO/$BRANCH/$SCRIPT_NAME"

SCRIPT_PATH="$INSTALL_DIR/$SCRIPT_NAME"

# Fonction pour afficher les messages d'erreur
function error_exit {
    echo "Erreur : $1" 1>&2
    exit 1
}

# Vérifier la présence de Python 3.7+
if command -v python3 &>/dev/null; then
    PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')
    PYTHON_MAJOR=$(python3 -c 'import sys; print(sys.version_info.major)')
    PYTHON_MINOR=$(python3 -c 'import sys; print(sys.version_info.minor)')
    if (( PYTHON_MAJOR < 3 )) || (( PYTHON_MAJOR == 3 && PYTHON_MINOR < 7 )); then
        error_exit "Python 3.7 ou supérieur est requis. Version actuelle : $PYTHON_VERSION"
    fi
else
    error_exit "Python3 n'est pas installé. Veuillez installer Python 3.7 ou supérieur."
fi

# Vérifier la présence de pip3
if ! command -v pip3 &>/dev/null; then
    echo "pip3 n'est pas installé. Installation de pip3..."
    sudo apt update || error_exit "Échec de l'update des paquets."
    sudo apt install -y python3-pip || error_exit "Échec de l'installation de pip3."
fi

# Installer la bibliothèque openai
echo "Installation de la bibliothèque openai..."
pip3 install --user openai || error_exit "Échec de l'installation de la bibliothèque openai."

# Créer le répertoire INSTALL_DIR s'il n'existe pas
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Création du répertoire $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR" || error_exit "Échec de la création du répertoire $INSTALL_DIR."
fi

# Télécharger le script git-llmcommit depuis GitHub
echo "Téléchargement du script $SCRIPT_NAME depuis GitHub..."
if command -v curl &>/dev/null; then
    curl -fSL "$SCRIPT_URL" -o "$SCRIPT_PATH" || error_exit "Échec du téléchargement du script depuis $SCRIPT_URL."
elif command -v wget &>/dev/null; then
    wget -q "$SCRIPT_URL" -O "$SCRIPT_PATH" || error_exit "Échec du téléchargement du script depuis $SCRIPT_URL."
else
    error_exit "Aucun gestionnaire de téléchargement trouvé (curl ou wget). Veuillez installer l'un des deux."
fi

# Vérifier si le script a été téléchargé
if [ ! -f "$SCRIPT_PATH" ]; then
    error_exit "Le script $SCRIPT_NAME n'a pas été téléchargé correctement."
fi

# Rendre le script exécutable
chmod +x "$SCRIPT_PATH" || error_exit "Échec de la modification des permissions du script."

echo "Le script $SCRIPT_NAME a été installé dans $INSTALL_DIR."

# Vérifier si INSTALL_DIR est dans PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "$INSTALL_DIR n'est pas dans votre PATH. Ajout à votre fichier de configuration du shell..."

    # Déterminer le fichier de configuration du shell
    if [ -n "$ZSH_VERSION" ]; then
        SHELL_CONFIG="$HOME/.zshrc"
    else
        SHELL_CONFIG="$HOME/.bashrc"
    fi

    # Ajouter INSTALL_DIR au PATH
    echo "export PATH=\$HOME/bin:\$PATH" >> "$SHELL_CONFIG"
    echo "Ajouté 'export PATH=\$HOME/bin:\$PATH' à $SHELL_CONFIG."

    # Recharger le fichier de configuration du shell
    source "$SHELL_CONFIG"
    echo "Rechargement de $SHELL_CONFIG terminé."
else
    echo "$INSTALL_DIR est déjà dans votre PATH."
fi

# Vérifier si OPENAI_API_KEY est défini
if [ -z "$OPENAI_API_KEY" ]; then
    echo "La variable d'environnement OPENAI_API_KEY n'est pas définie."
    read -s -p "Entrez votre clé API OpenAI : " API_KEY
    echo

    # Déterminer le fichier de configuration du shell
    if [ -n "$ZSH_VERSION" ]; then
        SHELL_CONFIG="$HOME/.zshrc"
    else
        SHELL_CONFIG="$HOME/.bashrc"
    fi

    # Ajouter la clé API au fichier de configuration du shell
    echo "export OPENAI_API_KEY=\"$API_KEY\"" >> "$SHELL_CONFIG"
    echo "Ajouté 'export OPENAI_API_KEY' à $SHELL_CONFIG."

    # Recharger le fichier de configuration du shell
    source "$SHELL_CONFIG"
    echo "Rechargement de $SHELL_CONFIG terminé."
else
    echo "La variable d'environnement OPENAI_API_KEY est déjà définie."
fi

echo "Installation terminée avec succès ! Vous pouvez maintenant utiliser la commande 'git llmcommit'."

echo "Exemple d'utilisation :"
echo "  git add ."
echo "  git llmcommit -d \"Ajout de la fonctionnalité de connexion utilisateur\""
