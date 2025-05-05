#!/bin/bash

# Caminhos
CONFIG_DIR="$HOME/.config/anydesk"
USER_CONF="$CONFIG_DIR/user.conf"
BACKUP_DIR="$HOME/BackupAnyDesk"
FAVORITES_BACKUP="/tmp/anydesk_favorites.txt"

echo "Encerrando o AnyDesk..."
pkill anydesk 2>/dev/null

# Backup dos favoritos
if [ -f "$USER_CONF" ]; then
    grep "^ad.roster.favorites=" "$USER_CONF" > "$FAVORITES_BACKUP"
    echo "Favoritos salvos em $FAVORITES_BACKUP"
else
    echo "Arquivo user.conf não encontrado, pulando backup de favoritos."
fi

# Deletar a pasta de configuração antiga
echo "Removendo configurações antigas..."
rm -rf "$CONFIG_DIR"

# Restaurar os arquivos de backup
echo "Restaurando arquivos de backup..."
mkdir -p "$CONFIG_DIR"
cp -r "$BACKUP_DIR/"* "$CONFIG_DIR/"

# Restaurar favoritos
if [ -f "$FAVORITES_BACKUP" ]; then
    cat "$FAVORITES_BACKUP" >> "$USER_CONF"
    rm "$FAVORITES_BACKUP"
    echo "Favoritos restaurados com sucesso."
else
    echo "Nenhum favorito para restaurar."
fi

# Iniciar o AnyDesk novamente
echo "Iniciando o AnyDesk..."
nohup anydesk >/dev/null 2>&1 &

echo "Processo concluído."
