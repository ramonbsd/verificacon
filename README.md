# verificacon
Script PowerShell para verificar conexões TCP estabelecidas com um IP remoto específico
 Permite identificar qual processo está conectado e, opcionalmente, encerrar o processo.

## Uso ##

```powershell
.\verifica-conexao.ps1 -TargetIP <IP>


## Funcionalidades ##
Verifica conexões TCP estabelecidas com um IP específico.

Identifica o processo e o usuário associado.

Oferece a opção de encerrar o processo diretamente pelo script

## Requisitos ##
PowerShell 5.1+
Permissões administrativas para encerrar processos de outros usuários

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
" altera temporariamente a política de execução de scripts PowerShell apenas para a sessão atual, permitindo que scripts sejam executados sem restrições, mesmo que a política global seja mais restritiva"

