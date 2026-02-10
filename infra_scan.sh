#!/bin/bash
# Auteur : William Lowe

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=== [SonarAudit-CLI] Lancement du Scan Universel ===${NC}"

read -p "ID du projet (Project Key) : " PROJECT_KEY
read -p "Token d'accès (doit commencer par sqp) : " PROJECT_TOKEN

# Nettoyage rapide du token (enlève les espaces)
PROJECT_TOKEN=$(echo $PROJECT_TOKEN | tr -d '[:space:]')

echo -e "\n${GREEN}Analyse SAST en cours...${NC}"

docker run --rm \
    --network=host \
    -v "$(pwd):/usr/src" \
    sonarsource/sonar-scanner-cli \
    -Dsonar.projectKey="$PROJECT_KEY" \
    -Dsonar.sources=. \
    -Dsonar.host.url="http://localhost:9000" \
    -Dsonar.token="$PROJECT_TOKEN" \
    -Dsonar.scm.disabled=true

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}Succès ! Voir sur : http://localhost:9000${NC}"
else
    echo -e "\n${RED}Erreur détectée. Vérifiez votre Token (sqp...) ou si le serveur est lancé.${NC}"
fi