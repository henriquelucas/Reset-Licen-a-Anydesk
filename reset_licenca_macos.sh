#!/bin/bash
# Reset AnyDesk (versão macOS, didática)
# ⚠️ Somente para estudo, não altera licenciamento real

SERVICE="com.anydesk.anydesk"    # exemplo de bundle ID do serviço
APP="/Applications/AnyDesk.app"
CONFIG_DIR="$HOME/Library/Application Support/AnyDesk"
TEMP_DIR="/tmp/anydesk_temp"

# ================================
# Função: Para o serviço e o app
# ================================
stop_any() {
    echo "Parando serviço e aplicativo..."

    # Para o serviço se existir
    if launchctl list | grep -q "$SERVICE"; then
        sudo launchctl stop "$SERVICE"
        echo "Serviço parado."
    else
        echo "Serviço não encontrado."
    fi

    # Mata o processo AnyDesk se estiver rodando
    pkill -f AnyDesk 2>/dev/null
}

# ================================
# Função: Inicia o aplicativo
# ================================
start_any() {
    echo "Iniciando AnyDesk..."

    if [ -d "$APP" ]; then
        open "$APP"
        echo "Aplicativo iniciado."
    else
        echo "Aplicativo não encontrado em $APP"
    fi
}

# ================================
# Salva e restaura configuração
# ================================
backup_config() {
    mkdir -p "$TEMP_DIR"
    cp -R "$CONFIG_DIR/user.conf" "$TEMP_DIR/" 2>/dev/null
    echo "Configuração salva temporariamente."
}

restore_config() {
    cp -R "$TEMP_DIR/user.conf" "$CONFIG_DIR/" 2>/dev/null
    rm -rf "$TEMP_DIR"
    echo "Configuração restaurada."
}

# ================================
# Fluxo principal
# ================================
stop_any
backup_config

# Aqui você poderia limpar miniaturas ou outros arquivos temporários
rm -rf "$CONFIG_DIR/thumbnails"

start_any

# Exemplo didático de esperar algo em system.conf
# (loop seguro com timeout)
TIMEOUT=30
COUNTER=0
while ! grep -q "ad.anynet.id=" "$CONFIG_DIR/system.conf" 2>/dev/null; do
    sleep 1
    COUNTER=$((COUNTER+1))
    if [ $COUNTER -ge $TIMEOUT ]; then
        echo "Timeout aguardando system.conf"
        break
    fi
done

stop_any
restore_config
start_any

echo "*********"
echo "Concluído."
