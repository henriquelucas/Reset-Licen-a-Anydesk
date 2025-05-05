# 🔄 Reset Licença Gratuita do AnyDesk

Este script permite **resetar a licença gratuita do AnyDesk**, removendo o bloqueio que impede conexões com outros dispositivos após o uso contínuo.  
⚠️ **Importante**: **isso não é um crack**. O objetivo é restaurar o funcionamento do AnyDesk com a licença gratuita, dentro dos limites da própria aplicação.

💡 **Recomendamos fortemente** adquirir uma licença oficial se o uso for frequente ou profissional.

---

## ⚙️ Requisitos

- AnyDesk deve estar instalado na máquina.
- Permissões de administrador (Windows) ou sudo (Linux), se necessário.

---

## 💻 Instruções para Windows

1. Baixe o arquivo `Anydesk-Reset.cmd` e siga os próximos passos ou execute apenas o código abaixo no PowerShell
   ```bash
   Invoke-WebRequest -Uri "https://raw.githubusercontent.com/henriquelucas/Reset-Licen-a-Anydesk/main/Anydesk-Reset.cmd" -OutFile "Anydesk_reset.cmd"; Start-Process "Anydesk_reset.cmd"

   
3. Clique com o botão direito e selecione **Executar como administrador**.
4. Aguarde a execução do script.
5. Se o AnyDesk não iniciar automaticamente, **reinicie o computador** manualmente.

---

## 🐧 Instruções para Linux

1. Salve o script como `anydesk_licenca.sh` ou faça o download
   ```bash
   wget https://raw.githubusercontent.com/henriquelucas/Reset-Licen-a-Anydesk/main/anydesk_licenca.sh
3. Dê permissão de execução:

   ```bash
   chmod +x anydesk_licenca.sh

4. Execute
   ```bash
   ./anydesk_licenca


## 🐧 Me paga um Café?
Você pode fazer uma contribuição por PIX pelo qrcode abaixo ou usando essa chave: 
 ```bash
00020126580014BR.GOV.BCB.PIX0136f0ced452-71ac-4953-81bf-e0d3f9a9c4965204000053039865802BR5923Henrique Lucas de Sousa6009SAO PAULO62140510WMg6htGSjk63045B58
<img src="https://raw.githubusercontent.com/henriquelucas/Reset-Licen-a-Anydesk/refs/heads/main/qrcode-pix.png" />
