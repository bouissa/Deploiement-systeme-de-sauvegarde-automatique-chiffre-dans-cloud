#!/bin/bash
set -euo pipefail

# Variables
GPG_KEY="Exemple8592C355197...."
USERS=("imad" "yassine")
BUCKET="Exemple-suvgarde-linux-session"
PREFIX="Ex-sessionsauvgarde"
REGION="eu-north-1"

# Répertoire/fichier de log (rotation quotidienne)
LOG_DIR="/home/yassine/logs/backup"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/duplicity_$(date +%F).log"

# Passphrase GPG (idéalement via l'environnement)
export PASSPHRASE="Exemple"

# Backend S3 moderne et région
export DUPLICITY_S3_USE_MULTIPART=1
export AWS_DEFAULT_REGION="$REGION"
export S3_USE_SIGV4=1

ok_list=()
err_list=()

{
  echo "===== $(date '+%F %T') | Début sauvegarde ====="

  for U in "${USERS[@]}"; do
    SRC="/home/$U"
    DEST="boto3+s3://${BUCKET}/${PREFIX}/${U}/"
    echo "--- $(date '+%T') | Sauvegarde user=${U} | SRC=${SRC} -> DEST=${DEST}"
    if duplicity --volsize 100 \
               --encrypt-key "$GPG_KEY" \
                 "$SRC" "$DEST"; then
      echo "OK  | ${U} | $(date '+%T')"
      ok_list+=("$U")
    else
      echo "ERR | ${U} | $(date '+%T')"
      err_list+=("$U")
    fi
  done

  echo "===== $(date '+%F %T') | Fin sauvegarde ====="
  echo "Succès: ${ok_list[*]:-aucun}"
  echo "Erreurs: ${err_list[*]:-aucune}"
} >> "$LOG_FILE" 2>&1

unset PASSPHRASE

# Récap sur stdout (utile pour cron)
echo "===== Récap sauvegarde ====="
echo "Succès: ${ok_list[*]:-aucun}"
echo "Erreurs: ${err_list[*]:-aucune}"
echo "Log: $LOG_FILE"

# Code de retour global
if [ "${#err_list[@]}" -gt 0 ]; then
  exit 1
fi

