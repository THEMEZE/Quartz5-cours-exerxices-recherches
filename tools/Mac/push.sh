#!/bin/bash
set -e

echo "Synchronisation..."

git add .

if git diff --cached --quiet
then
    echo "Aucun changement"
    exit 0
fi

MESSAGE="${1:-Mise a jour notes}"

git commit -m "$MESSAGE"
git pull --rebase origin main
git push origin main

echo "Envoye sur GitHub -- pense a lancer tools/Raspberry/update_content.sh sur le Raspberry"
