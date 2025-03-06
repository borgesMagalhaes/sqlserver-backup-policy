# 📚 SQL Server - Política Completa de Backup

Este repositório contém uma **política completa de backup para ambientes SQL Server**, cobrindo todos os aspectos necessários para garantir a segurança e a integridade dos dados em bancos de dados SQL Server.

O conteúdo inclui:

- **Scripts de backup automático** para:

  - Backups completos (Full) diários.
  - Backups diferenciais a cada 6 horas.
  - Backups de log de transações a cada 15 minutos.

- **Script de limpeza automática** para remoção de backups antigos, mantendo apenas os backups conforme a política de retenção definida.

- **Orientações de configuração**, incluindo:

  - Criação de estrutura de pastas.
  - Configuração de jobs no SQL Server Agent.
  - Criação de tarefas agendadas no Windows Task Scheduler.

- **Melhores práticas de segurança** e **recomendações de testes periódicos de restauração** para validar a integridade dos backups.

Com esse repositório, você poderá implementar uma solução robusta de backup para ambientes SQL Server, garantindo proteção contra falhas, perdas acidentais e corrupção de dados.

---

## 📜 Política de Retenção (Resumida)

| Tipo de Backup        | Frequência           | Retenção |
| --------------------- | -------------------- | -------- |
| **Full**              | Diariamente às 01:00 | 7 dias   |
| **Diferencial**       | A cada 6 horas       | 7 dias   |
| **Log de Transações** | A cada 15 minutos    | 3 dias   |

---

## 📂 Organização dos Arquivos

- **BackupFull.sql**: Backup completo diário.
- **BackupDiferencial.sql**: Backup diferencial a cada 6 horas.
- **BackupLog.sql**: Backup de log de transações a cada 15 minutos.
- **LimpezaBackupsSQL.ps1**: Limpeza automática de backups antigos.
- **README.md**: Documentação completa com passo a passo de configuração e boas práticas.

---

## 🧰 Pré-requisitos

- SQL Server 2016 ou superior.
- Permissões de administrador para configurar SQL Server Agent e Tarefas Agendadas no Windows.
- Acesso administrativo às pastas de backup.

---

## 📧 Suporte e Contato

Criado por **Bruno Magalhães - Analista de Software**

Fique à vontade para contribuir ou adaptar conforme sua realidade.

---

## 🗂️ Estrutura de Diretórios

D:\SQLBackups\ Full\ # Backups completos Diferencial\ # Backups diferenciais Log\ # Backups de log de transações

C:\Scripts\ LimpezaBackupsSQL.ps1 # Script de limpeza automática

---

## 📋 Política de Retenção Completa

| Tipo de Backup        | Frequência           | Retenção |
| --------------------- | -------------------- | -------- |
| **Full**              | Diariamente às 01:00 | 7 dias   |
| **Diferencial**       | A cada 6 horas       | 7 dias   |
| **Log de Transações** | A cada 15 minutos    | 3 dias   |

---

## ⚙️ Configuração e Agendamento

### 1. Criar pastas para armazenar os backups

```powershell
New-Item -ItemType Directory -Path "D:\\SQLBackups\\Full"
New-Item -ItemType Directory -Path "D:\\SQLBackups\\Diferencial"
New-Item -ItemType Directory -Path "D:\\SQLBackups\\Log"
New-Item -ItemType Directory -Path "C:\\Scripts"
```
### 2. Criar os Jobs no SQL Server Agent
Backup Full (Diário)
Nome: Backup Full Diário
Frequência: Diário, 01:00
Script utilizado: BackupFull.sql
Backup Diferencial (6 em 6 horas)
Nome: Backup Diferencial
Frequência: 06:00, 12:00 e 18:00
Script utilizado: BackupDiferencial.sql
Backup de Log (a cada 15 minutos)
Nome: Backup Log Transações
Frequência: A cada 15 minutos
Script utilizado: BackupLog.sql
### 3. Agendar a Limpeza no Windows Task Scheduler
Criar uma nova tarefa agendada.
Configurar execução diária (recomendado às 02:00).
Comando da tarefa:

```
powershell.exe -ExecutionPolicy Bypass -File "C:\\Scripts\\LimpezaBackupsSQL.ps1"
```

estes de Recuperação (Recomendado)
Teste	Frequência
Restore completo (Full + Diff + Logs)	Mensal
Simulação de perda parcial	Trimestral
Verificação de consistência (DBCC CHECKDB) após restore	Mensal
### 🔐 Segurança e Boas Práticas
Restrinja permissões nas pastas de backup.
Utilize criptografia em backups sensíveis.
Realize testes periódicos de restauração.
Monitore falhas com alertas no SQL Server Agent (Database Mail)
```
