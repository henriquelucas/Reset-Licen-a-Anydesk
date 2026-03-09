
# 🔄 Reset (ID) Licença Gratuita do AnyDesk

Este script permite **resetar a licença gratuita do AnyDesk**, removendo o bloqueio que impede conexões com outros dispositivos após uso contínuo.  
> ⚠️ **Importante**: **isso não é um crack**. O objetivo é restaurar o funcionamento do AnyDesk com a licença gratuita, dentro dos limites da própria aplicação. Ele não irá destravrar permanentemente o teu anydesk! Apenas server pra que você possa experiementar o uso gratuito novamente sem interrupções.

> 💡 **Recomendamos fortemente** adquirir uma licença oficial se o uso for frequente ou profissional.
> Ou se preferir monte seu próprio servidor com Rustdesk, é OpenSource e auto-hospedado! Veja como instalar <a href="https://github.com/henriquelucas/Rustdesk-Server/tree/main" />clique aqui</a>.
---

## ⚙️ Requisitos

- AnyDesk deve estar instalado na máquina.
- Permissões de administrador (Windows) ou `sudo` (Linux), se necessário.

---

## 💻 Instruções para Windows

### ✔️ Método automático (PowerShell)

Execute o comando abaixo no PowerShell (como administrador):

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/henriquelucas/Reset-Licen-a-Anydesk/main/Anydesk-Reset.cmd" -OutFile "Anydesk_reset.cmd"; Start-Process "Anydesk_reset.cmd"
```

### 🧭 Método manual

1. Baixe o arquivo [`Anydesk-Reset.cmd`](https://raw.githubusercontent.com/henriquelucas/Reset-Licen-a-Anydesk/main/Anydesk-Reset.cmd)  
2. Clique com o botão direito e selecione **"Executar como administrador"**.  
3. Aguarde a execução do script.  
4. Se o AnyDesk não iniciar automaticamente, **reinicie o computador manualmente**.

---

## 🐧 Instruções para Linux

1. Baixe o script:
   ```bash
   wget https://raw.githubusercontent.com/henriquelucas/Reset-Licen-a-Anydesk/main/anydesk_licenca.sh
   ```

2. Dê permissão de execução:
   ```bash
   chmod +x anydesk_licenca.sh
   ```

3. Execute o script:
   ```bash
   ./anydesk_licenca.sh
   ```

## 🐧 Instruções para Mac

1. Baixe e execute usando:
   ```bash
   curl -s https://raw.githubusercontent.com/henriquelucas/Reset-Licen-a-Anydesk/refs/heads/main/reset_licenca_macos.sh | bash
   ```
---

## ☕ Me paga um Café?

Você pode fazer uma contribuição por PIX pelo QR Code abaixo ou usando esta chave:

```bash
00020126580014BR.GOV.BCB.PIX0136f0ced452-71ac-4953-81bf-e0d3f9a9c4965204000053039865802BR5923Henrique Lucas de Sousa6009SAO PAULO62140510WMg6htGSjk63045B58
```

```bash
00020126580014BR.GOV.BCB.PIX0136f0ced452-71ac-4953-81bf-e0d3f9a9c4965204000053039865802BR5923Henrique Lucas de Sousa6009SAO PAULO62140510WMg6htGSjk63045B58
```

 Ou pelo PayPal:
 [Doar via PayPal](https://www.paypal.com/donate/?business=PCFJCNK8GGJN2&no_recurring=0&currency_code=BRL)

<img src="https://raw.githubusercontent.com/henriquelucas/Reset-Licen-a-Anydesk/refs/heads/main/qrcode-pix.png" width="200" />

---

🔗 Feito com dedicação por [@henriquelucas](https://github.com/henriquelucas)
