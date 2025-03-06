# Caminhos das pastas de backup
$BackupPaths = @(
    "D:\SQLBackups\Full",
    "D:\SQLBackups\Diferencial",
    "D:\SQLBackups\Log"
)

# Quantos dias de retenção
$DaysToKeep = 7

# Percorrer cada pasta e remover arquivos antigos
foreach ($Path in $BackupPaths) {
    if (Test-Path $Path) {
        Get-ChildItem -Path $Path -File |
        Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$DaysToKeep) } |
        Remove-Item -Force
    }
}
