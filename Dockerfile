FROM python:3.12-slim

# Installation d'OpenSSL pour générer le certificat
RUN apt-get update && apt-get install -y --no-install-recommends openssl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copie de tout le code dans l'image
COPY . .

# Copie du script entrypoint dans l'image
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5000

# On utilise l'entrypoint pour générer le certif
ENTRYPOINT ["/entrypoint.sh"]
