# Verifica se o Winget está instalado
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget não está instalado neste sistema." -Foreground Red
    exit
} else {
    #
    Write-Host "####### Verificando pacotes #######" -Foreground Magenta
    $result = winget search --accept-source-agreements moba
}

# Lista de pacotes a serem instalados
$packages = @(
    "Microsoft.VCRedist.2015+.x64",
    "Microsoft.VCRedist.2015+.x86",
    "Oracle.JDK.23",
    "Oracle.VirtualBox",
    "Mobatek.MobaXterm",
    "Notepad++.Notepad++",
    "Adobe.Acrobat.Reader.64-bit",
    "RARLab.WinRAR",
    "Microsoft.VisualStudioCode",
    "Canva.Canva",
    "Microsoft.MouseandKeyboardCenter",
    "9NQ3HDB99VBF",
    "9NKSQGP7F2NH",
    "Google.Chrome"
)

# Caminho para salvar o log
$logPath = "$env:USERPROFILE\AppData\Local\Temp\winget_install_log.txt"

# Função para verificar se o pacote já está instalado
function Is-PackageInstalled {
    param (
        [string]$PackageName
    )

    $installedPackages = winget list | ForEach-Object { $_.Trim() }
    foreach ($line in $installedPackages) {
        if ($line -like "*$PackageName*") {
            return $true
        }
    }
    return $false
}

# Função para instalar pacotes
function Install-Package {
    param (
        [string]$PackageName
    )

    if (Is-PackageInstalled -PackageName $PackageName) {
        Write-Host "$PackageName já está instalado. Pulando..." -Foreground Cyan
        Add-Content -Path $logPath -Value "$PackageName Já instalado - $(Get-Date)"
    } else {
        Write-Host "Instalando $PackageName..." -ForegroundColor Yellow
        
        # Condição especial para o Visual Studio Code (VSCode)
        if ($PackageName -eq "Microsoft.VisualStudioCode") {
            # Instalação silenciosa para VSCode
            $result = winget install --id $PackageName --scope machine --silent --accept-package-agreements --accept-source-agreements
        } else {
            # Instalação silenciosa para outros pacotes
            $result = winget install -e --id $PackageName --silent --accept-package-agreements --accept-source-agreements
        }
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "$PackageName instalado com sucesso." -Foreground Green
            Add-Content -Path $logPath -Value "$PackageName Sucesso - $(Get-Date)"
        } else {
            Write-Host "Falha ao instalar $PackageName." -Foreground Red
            Add-Content -Path $logPath -Value "$PackageName Falha - $(Get-Date)"
        }
    }
}

# Loop pelos pacotes para instalar
foreach ($package in $packages) {
    Install-Package -PackageName $package
}

$scripts = Set-ExecutionPolicy Restricted -Scope Process -Force
Write-Host "Processo de instalação concluído. Verifique os logs em $logPath" -Foreground Yellow
