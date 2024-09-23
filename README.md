# LLMCommit

**LLMCommit** est un assistant automatisé pour générer des messages de commit Git clairs et concis en utilisant l'API OpenAI. Ce script facilite le processus de création de commits en analysant les modifications mises en scène et en proposant un message pertinent.

## Table des Matières

- [Fonctionnalités](#fonctionnalités)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Configuration](#configuration)
- [Utilisation](#utilisation)
- [Exemples](#exemples)
- [Bonnes Pratiques](#bonnes-pratiques)
- [Sécurité](#sécurité)
- [Contribution](#contribution)
- [Licence](#licence)

## Fonctionnalités

- **Génération Automatique de Messages de Commit** : Utilise l'API OpenAI pour créer des messages de commit basés sur les changements dans le dépôt.
- **Option de Description Personnalisée** : Permet à l'utilisateur de fournir une description supplémentaire pour contextualiser le commit.
- **Intégration en tant que Sous-Commande Git** : Fonctionne directement avec Git via une commande personnalisée.
- **Lecture du README** : Inclut le contenu du README du projet pour fournir un contexte supplémentaire.

## Prérequis

Avant d'utiliser LLMCommit, assurez-vous d'avoir les éléments suivants :

1. **Python 3.7+** : Installé sur votre système.
2. **Compte OpenAI** : Avec une clé API valide.
3. **Dépôt Git Initialisé** : Avec des changements mis en scène (`git add`).

## Installation

### 1. Cloner ou Télécharger le Script

Clonez ce dépôt ou téléchargez le script directement.

```bash
git clone https://votre-repo-llmcommit.git
cd llmcommit
