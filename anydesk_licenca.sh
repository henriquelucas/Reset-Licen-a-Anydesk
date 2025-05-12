#!/bin/bash

echo "Resetando AnyDesk..."

# Verifica se está como root
if [[ $EUID -ne 0 ]]; then
   echo "Por favor, execute como root (sudo)." 
   exit 1
fi

stop_any() {
    echo "Parando AnyDesk..."
    systemctl stop anydesk
    pkill -f anydesk
}

start_any() {
    echo "Iniciando AnyDesk..."
    systemctl start anydesk
    sleep 2
    # Tenta iniciar manualmente se necessário
    command -v anydesk >/dev/null && nohup anydesk >/dev/null 2>&1 &
}

TEMP_DIR="/tmp/anydesk_reset"
USER_CONF="$HOME/.anydesk/user.conf"
SERVICE_CONF_SYS="/etc/anydesk/service.conf"
SERVICE_CONF_USER="$HOME/.anydesk/service.conf"
THUMB_DIR="$HOME/.anydesk/thumbnails"

stop_any

mkdir -p "$TEMP_DIR"

# Backup arquivos de usuário
cp -f "$USER_CONF" "$TEMP_DIR/user.conf" 2>/dev/null
cp -r "$THUMB_DIR" "$TEMP_DIR/thumbnails" 2>/dev/null

# Remove configurações
rm -f "$SERVICE_CONF_SYS" "$SERVICE_CONF_USER"
rm -rf "$HOME/.anydesk"/*

start_any

# Aguarda system.conf aparecer com ID válido (simulação)
while ! grep -q "ad.anynet.id=" /etc/anydesk/system.conf 2>/dev/null; do
    sleep 1
done

# Restaurar dados
stop_any
mkdir -p "$HOME/.anydesk/thumbnails"
cp -f "$TEMP_DIR/user.conf" "$USER_CONF" 2>/dev/null
cp -r "$TEMP_DIR/thumbnails/"* "$HOME/.anydesk/thumbnails/" 2>/dev/null

rm -rf "$TEMP_DIR"

start_any

echo "*********"
echo "Concluído."
