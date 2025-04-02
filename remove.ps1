$FilePath = "D:\VM's\Machines\DevOps"
# Gerar dados aleatórios e sobrescrever o arquivo
$bytes = New-Object byte[] 2048
$rand = New-Object Random
$rand.NextBytes($bytes)

# Sobrescrever o arquivo com dados aleatórios
[IO.File]::WriteAllBytes($FilePath, $bytes)

# Apagar o arquivo irrecuperavelmente
Remove-Item -Path $FilePath -Force