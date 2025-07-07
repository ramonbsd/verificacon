param (
    [string]$TargetIP
)

# Verifica se o IP foi informado
if (-not $TargetIP) {
    Write-Host "Uso: .\verifica-conexao.ps1 -TargetIP <IP>"
    exit
}

Write-Host "Procurando conexões estabelecidas com o IP informado $TargetIP..."

# Verificando conexões com o IP informado
$conexoes = Get-NetTCPConnection -State Established | Where-Object { $_.RemoteAddress -eq $TargetIP }

if ($conexoes.Count -eq 0) {
    Write-Host "Nenhuma conexão estabelecida com o IP $TargetIP foi encontrada."
    exit
}

foreach ($con in $conexoes) {
    $pid = $con.OwningProcess
    $proc = Get-Process -Id $pid -ErrorAction SilentlyContinue

    if ($proc) {
        # Verificando o usuário do processo
        try {
            $wmi = Get-CimInstance Win32_Process -Filter "ProcessId = $pid"
            $userInfo = $wmi.GetOwner()
            $usuario = "$($userInfo.Domain)\$($userInfo.User)"
        } catch {
            $usuario = "Desconhecido"
        }

        Write-Host "`nConexão encontrada:"
        Write-Host "  IP Remoto: $($con.RemoteAddress):$($con.RemotePort)"
        Write-Host "  Local: $($con.LocalAddress):$($con.LocalPort)"
        Write-Host "  PID: $pid"
        Write-Host "  Processo: $($proc.ProcessName)"
        Write-Host "  Usuário: $usuario"

        $resposta = Read-Host "Deseja encerrar este processo? (s/n)"
        if ($resposta -eq "s") {
            try {
                Stop-Process -Id $pid -Force
                Write-Host "Processo $($proc.ProcessName) (PID $pid) encerrado com sucesso."
            } catch {
                Write-Host "Erro ao encerrar o processo: $_"
            }
        }
    } else {
        Write-Host "Não foi possível obter o processo com PID $pid"
    }
}
