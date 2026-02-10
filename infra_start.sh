#!/bin/bash
# Auteur : William Lowe
# Description : Lancement de l'infrastructure d'analyse avancée

BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${BLUE}=== [OmniAudit-CLI] Initialisation de l'infrastructure ===${NC}"

# Lancement du moteur d'analyse
docker run -d --name Sonariaudit_engine \
    -p 9000:9000 \
    -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true \
    sonarqube:community

echo -e "${GREEN}Démarrage des services...${NC}"
until $(curl --output /dev/null --silent --head --fail http://localhost:9000); do
    printf '.'
    sleep 5
done

echo -e "\n${GREEN}INFRASTRUCTURE PRÊTE : http://localhost:9000${NC}"