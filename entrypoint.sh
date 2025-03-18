#!/bin/bash
set -e

# Chemin où stocker la clé et le certificat
CERT_DIR=/app/instance
KEY_FILE=$CERT_DIR/ssl.key
CRT_FILE=$CERT_DIR/ssl.crt

# On crée le dossier /app/instance s'il n'existe pas
mkdir -p "$CERT_DIR"

# Si les fichiers n'existent pas, on les génère
if [ ! -f "$KEY_FILE" ] || [ ! -f "$CRT_FILE" ]; then
  echo ">>> Génération du certificat auto-signé..."
  openssl req -x509 -newkey rsa:4096 -days 365 -nodes \
    -keyout "$KEY_FILE" \
    -out "$CRT_FILE" \
    -subj "/C=FR/ST=Occitanie/L=Beziers/O=SPC/OU=Projet/CN=localhost"
fi

echo ">>> Lancement de l'application Flask..."
exec python app.py
