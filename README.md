<!-- Bannière ou Titre Principal -->
# 🔐 Système de Sauvegarde Automatique & Chiffrée vers le Cloud

<div align="center">

### 🚀 Sauvegarde incrémentielle – 🔒 Chiffrement GPG – ☁️ Stockage AWS S3

![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![License](https://img.shields.io/badge/License-Academic-blue)
![Contributions welcome](https://img.shields.io/badge/Contributions-Welcome-orange)

</div>

---

## 🏷️ Badges Techniques

| Technologie | Badge |
|------------|-------|
| **AWS S3** | ![AWS](https://img.shields.io/badge/AWS-S3-orange?logo=amazonaws&logoColor=white) |
| **Debian 12** | ![Debian](https://img.shields.io/badge/Debian-12-red?logo=debian&logoColor=white) |
| **Bash Scripting** | ![Bash](https://img.shields.io/badge/Bash-Scripting-black?logo=gnubash&logoColor=white) |
| **Duplicity** | ![Duplicity](https://img.shields.io/badge/Duplicity-Backup-blue) |
| **GPG Encryption** | ![GPG](https://img.shields.io/badge/GPG-Encryption-lightgrey?logo=gnuprivacyguard&logoColor=white) |
| **Cron** | ![Cron](https://img.shields.io/badge/Cron-Jobs-green) |

---

# 📚 Sommaire

1. [📋 Description du Projet](#-description-du-projet)  
2. [🚀 Fonctionnalités](#-fonctionnalités)  
3. [🛠️ Architecture Technologique](#️-architecture-technologique)  
4. [📁 Structure du Projet](#-structure-du-projet)  
5. [🔧 Installation & Configuration](#-installation--configuration)  
6. [📝 Utilisation](#-utilisation)  
7. [🔒 Sécurité](#-sécurité)  
8. [📊 Monitoring & Maintenance](#-monitoring--maintenance)  
9. [🚨 Dépannage](#-dépannage)  
10. [📈 Améliorations Futures](#-améliorations-futures)  
11. [👥 Contribution](#-contribution)  
12. [📚 Documentation Supplémentaire](#-documentation-supplémentaire)  
13. [📄 Licence](#-licence)  

---

# 📋 Description du Projet

Ce projet de **PFA (Projet de Fin d’Année)** implémente un système automatisé pour :

✔️ Sauvegarder les répertoires utilisateurs sous Linux  
✔️ Chiffrer les données via **GPG**  
✔️ Envoyer uniquement les modifications (incrémentiel) via **Duplicity**  
✔️ Stocker sur **AWS S3**  
✔️ Journaliser toutes les opérations  

---

## 👨‍💻 Équipe de développement

- Mouhcine Oualyali  
- Khalid Alhyane  
- **Yassine Bouissa**  
- Imad Ibrghoutn  
- Abdessamad Miqasse  

**Encadrant : AIT Ibourek Lahcen**

---

# 🚀 Fonctionnalités

- 🔄 Sauvegarde automatisée  
- 🔐 Chiffrement GPG (client-side)  
- ☁️ Stockage sécurisé S3  
- 📈 Sauvegardes incrémentielles  
- 👤 Isolation par utilisateur  
- 📝 Logs complets  
- ♻️ Restauration ciblée  
- ⏱️ Cron intégré  
- ❗ Gestion des erreurs  

---

# 🛠️ Architecture Technologique

## 📦 Diagramme Mermaid (Architecture Globale)

``
mermaid
flowchart TD
    A[Utilisateurs Linux] --> B[Script Bash + Duplicity]
    B --> C[GPG - Chiffrement]
    C --> D[Transfert Sécurisé]
    D --> E[AWS S3 Bucket]
    E -->|sessionsauvgarde/yassine| F[Yassine]
    E -->|sessionsauvgarde/imad| G[Imad]``

## 📁 Structure du Projet

``projet-sauvegarde-cloud/
├── README.md
├── Rapport_Sauvegarde_Cloud.docx
├── script_save_linux_sessions.sh
├── media/
│   ├── image1.png
│   ├── image2.png
│   └── ...
└── logs/
    └── backup/
        └── duplicity_YYYY-MM-DD.log``
        
## 🔧 Installation & Configuration
# 1️⃣ Installer les dépendances

``sudo apt update
sudo apt install -y duplicity python3-pip gnupg curl
pip3 install boto3 awscli``

# 2️⃣ Configurer AWS
``aws configure``

# 3️⃣ Générer la clé GPG
``gpg --gen-key``

# 4️⃣ Configurer le script
``Variables à modifier dans script_save_linux_sessions.sh :
    - GPG_KEY
    - USERS
    - BUCKET
    - PASS_PHRASE``

# 5️⃣ Rendre le script exécutable
``chmod +x script_save_linux_sessions.sh``

# 6️⃣ Ajouter dans Cron
``crontab -e``
``30 2 * * 0 /path/script_save_linux_sessions.sh``

# 📝 Utilisation
# ▶️ Lancer une sauvegarde
``./script_save_linux_sessions.sh``

# 📄 Consulter les logs
``tail -f /home/imad/logs/backup/duplicity_$(date +%F).log``

# 📦 Lister les sauvegardes
``duplicity list-current-files boto3+s3://suvgarde-linux-session/sessionsauvgarde/name/``

# ♻️ Restaurer un fichier
``duplicity restore --file-to-restore chemin/du/fichier \
  boto3+s3://suvgarde-linux-session/sessionsauvgarde/user/ \
  /destination/``
  
# 🔒 Sécurité
# 🔐 Chiffrement
- GPG avant envoi
- Clés asymétriques
- Passphrase non stockée en clair

# 🛡️ IAM
- Utilisateur AWS dédié
- Permissions minimales
- Rotation périodique

# 🧩 Isolation
- Sauvegardes séparées par préfixe S3
- Logs non sensibles

# 📊 Monitoring & Maintenance
- Logs dans :
``/home/name/logs/backup/``
- Test de restauration recommandé chaque semaine
- Rotation des clés GPG/AWS chaque trimestre

# 🚨 Dépannage

| Problème                   | Solution                          |
|---------------------------|------------------------------------|
| No module named 'boto'    | `sudo apt install python3-boto`    |
| Erreur AWS                | `aws configure`                    |
| Permission denied         | Exécuter en sudo                   |
| Espace disque faible      | Nettoyer le cache Duplicity        |


# 📈 Améliorations Futures
- UI web de monitoring
- Alertes e-mail/SMS
- Politique de rétention automatique
- Support multi-cloud
- Dashboard métriques

# 👥 Contribution
1. Fork
2. Nouvelle branche
3. Commit
4. Push
5. Pull Request

# 📚 Documentation Supplémentaire
- AWS S3
- Duplicity
- GPG
- IAM Best Practices
. ISO/IEC 27001
. RGPD
. Règle 3-2-1

## 📄 Licence

Ce projet est réalisé dans un cadre **académique**.
Pour une **version professionnelle** adaptée à vos besoins ou pour toute **utilisation commerciale**, veuillez me contacter.  
Toute exploitation commerciale nécessite une **autorisation préalable**.
