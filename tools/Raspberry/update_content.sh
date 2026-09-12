#!/bin/bash
set -e

GREEN='\033[92m'; YELLOW='\033[93m'; RED='\033[91m'; BLUE='\033[94m'; RESET='\033[0m'; BOLD='\033[1m'
ok()   { echo -e "${GREEN}  ✅  $1${RESET}"; }
warn() { echo -e "${YELLOW}  ⚠️   $1${RESET}"; }
err()  { echo -e "${RED}  ❌  $1${RESET}"; exit 1; }
info() { echo -e "${BLUE}  ℹ️   $1${RESET}"; }

# ============================================================
# Quartz5/tools/Raspberry/update_content.sh
#
# Contrairement à CoursOndes/tools/Raspberry/update_code.sh, ce script
# ne gère AUCUN service (pas de gunicorn, pas de tunnel, pas de nginx à
# lui) : Quartz5 n'est pas un serveur, juste un dossier de contenu +
# un outil de build. C'est CoursOndes qui sert le résultat (public/) via
# son propre nginx -- voir CoursOndes/DEPLOY_RASPBERRY.md.
#
# Ce script :
#   1. Met à jour TES notes perso (git pull)
#   2. Régénère le contenu du cours d'ondes par-dessus (délégué à
#      CoursOndes/web/publish_profile.sh, qui sait quel profil est actif)
#   3. Reconstruit le site (npx quartz build)
# ============================================================

QUARTZ_DIR="/mnt/mariage_data/Quartz5"
COURS_DIR="/mnt/mariage_data/CoursOndes"

echo ""
echo -e "${BOLD}╔══════════════════════════════════════════╗"
echo    "║      🌱 Jardin numérique — Update        ║"
echo -e "╚══════════════════════════════════════════╝${RESET}"
echo ""

cd "$QUARTZ_DIR" || err "Introuvable : $QUARTZ_DIR"

info "Mise à jour des notes personnelles (git)..."
git fetch origin
git reset --hard origin/main
ok "Notes à jour"

if [ -d node_modules ]; then
    info "npm install (si package.json a changé)..."
    npm install --no-audit --no-fund -q
    ok "Dépendances Quartz à jour"
else
    warn "node_modules absent -- premier lancement : npm install requis"
    npm install
fi

if [ -d "$COURS_DIR" ]; then
    info "Régénération du contenu du cours d'ondes (délégué à CoursOndes)..."
    PROFILE="avant_seance"
    [ -f "$COURS_DIR/web/.current_profile" ] && PROFILE="$(cat "$COURS_DIR/web/.current_profile")"
    QUARTZ_CONTENT="$QUARTZ_DIR/content" "$COURS_DIR/web/publish_profile.sh" "$PROFILE"
    ok "Contenu du cours régénéré (profil '$PROFILE')"
else
    warn "$COURS_DIR introuvable -- section physique/ipsa-ondes non régénérée"
fi

info "Build Quartz..."
npx quartz build
ok "Site reconstruit dans $QUARTZ_DIR/public"

echo ""
ok "Jardin numérique à jour 🌱"
echo "   (nginx sert déjà $QUARTZ_DIR/public -- rien d'autre à redémarrer)"
echo ""
