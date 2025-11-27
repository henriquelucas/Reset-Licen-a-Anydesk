#!/bin/bash

echo "Resetando AnyDesk (macOS)..."

# Serve root per modificare /etc/anydesk
if [[ $EUID -ne 0 ]]; then
   echo "Per favore, esegui come root (sudo)."
   exit 1
fi

APP_BIN="/Applications/AnyDesk.app/Contents/MacOS/AnyDesk"

stop_any() {
    echo "Parando AnyDesk..."
    # Chiude tutti i processi AnyDesk (service, hub, control)
    pkill -f "$APP_BIN" 2>/dev/null
}

start_any() {
    echo "Iniciando AnyDesk..."
    # Avvia l'app AnyDesk
    open -a "AnyDesk"
    sleep 3
}

TEMP_DIR="/tmp/anydesk_reset"

# Cartella utente *come nel tuo script originale*
USER_DIR="$HOME/.anydesk"
USER_CONF="$USER_DIR/user.conf"
SERVICE_CONF_SYS="/etc/anydesk/service.conf"
SERVICE_CONF_USER="$USER_DIR/service.conf"
THUMB_DIR="$USER_DIR/thumbnails"
SYSTEM_CONF="/etc/anydesk/system.conf"

stop_any

mkdir -p "$TEMP_DIR"

echo "Backup dati utente (se presenti)..."

# Backup user.conf
if [ -f "$USER_CONF" ]; then
    cp -f "$USER_CONF" "$TEMP_DIR/user.conf"
fi

# Backup thumbnails
if [ -d "$THUMB_DIR" ]; then
    cp -R "$THUMB_DIR" "$TEMP_DIR/thumbnails"
fi

echo "Rimozione configurazioni..."

# Rimuove config di servizio (sistema + utente)
rm -f "$SERVICE_CONF_SYS" "$SERVICE_CONF_USER" 2>/dev/null

# Svuota la cartella utente AnyDesk, se esiste
if [ -d "$USER_DIR" ]; then
    rm -rf "$USER_DIR"/*
fi

start_any

echo "Aspetto che AnyDesk rigeneri l'ID in $SYSTEM_CONF..."

# Timeout massimo 60 secondi per evitare loop infinito
for i in {1..60}; do
    if grep -q "ad.anynet.id=" "$SYSTEM_CONF" 2>/dev/null; then
        echo "ID trovato in $SYSTEM_CONF."
        break
    fi
    sleep 1
done

echo "Restauro dei dati utente salvati..."

stop_any

# Ricrea thumbnails e ripristina
mkdir -p "$THUMB_DIR"

if [ -f "$TEMP_DIR/user.conf" ]; then
    cp -f "$TEMP_DIR/user.conf" "$USER_CONF"
fi

if [ -d "$TEMP_DIR/thumbnails" ]; then
    cp -R "$TEMP_DIR/thumbnails/"* "$THUMB_DIR/" 2>/dev/null
fi

rm -rf "$TEMP_DIR"

start_any

echo "*********"
echo "Concluído (macOS)."

# e alla fine...
# chmod +x ~/reset_anydesk_macos.sh
# sudo ~/reset_anydesk_macos.sh
