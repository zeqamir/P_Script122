<#
.NOTES
Nom du Script     : ScriptMenuProjet.ps1
Prérequis         : PowerShell 7.4.0
Version du Script : 1.0
Auteur            : Amir Zeqiri
Date de création  : 13.12.2023
Lieu              : ETML, Sébeillion
Changements       : Aucun

.SYNOPSIS
Ce script fournit une interface interactive basée sur un menu pour effectuer
diverses opérations sur les fichiers et les répertoires, générer des rapports
sur l'état du système et gérer les services.

.DESCRIPTION
Script pour des opérations interactives basées sur un menu :
- Option 1 : Opérations sur les fichiers et les répertoires.
- Option 2 : Générer des rapports sur l'état du système.
- Option 3 : Gérer les services.

.EXAMPLE
.\ScriptMenuProjet.ps1
#>

# Fonction pour afficher le menu de l'Option 1
function ShowMenuOption1 {
    Clear-Host
    Write-Host "Option 1"
    Write-Host "1. Gérer un répertoire"
    Write-Host "2. Gérer un fichier"
    Write-Host "0. Quitter option 1"
}

# Fonction pour la gestion des répertoires
function DirectoryManagement {
    $path = Read-Host "Entrez le chemin du répertoire à gérer"
    
    if (Test-Path $path -PathType Container) {
        Write-Host "1. Copier le répertoire"
        Write-Host "2. Supprimer le répertoire"
        Write-Host "3. Déplacer le répertoire"
        $choice = Read-Host "Faites votre choix"

        switch ($choice) {
            1 { Copy-Item $path -Destination (Read-Host "Entrez le chemin de destination") -Recurse }
            2 { Remove-Item $path -Recurse -Force }
            3 { Move-Item $path -Destination (Read-Host "Entrez le nouveau chemin") }
            default { Write-Host "Choix non valide" }
        }
    }
    else {
        Write-Host "Le chemin spécifié n'est pas un répertoire."
        Pause
    }
}

# Fonction pour la gestion des fichiers
function FileManagement {
    $path = Read-Host "Entrez le chemin du fichier à gérer"

    if (Test-Path $path -PathType Leaf) {
        Write-Host "1. Copier le fichier"
        Write-Host "2. Supprimer le fichier"
        Write-Host "3. Déplacer le fichier"
        $choice = Read-Host "Faites votre choix"

        switch ($choice) {
            1 { Copy-Item $path -Destination (Read-Host "Entrez le chemin de destination") }
            2 { Remove-Item $path -Force }
            3 { Move-Item $path -Destination (Read-Host "Entrez le nouveau chemin") }
            default { Write-Host "Choix non valide" }
        }
    }
    else {
        Write-Host "Le chemin spécifié n'est pas un fichier."
        Pause
    }
}

# Fonction pour afficher le menu de l'Option 2
function ShowMenuOption2 {
    Clear-Host
    Write-Host "Option 2"
    Write-Host "1. Générer un rapport CSV sur l'état du système"
    Write-Host "0. Quitter option 2"
}

# Fonction pour créer un rapport sur l'état du système (Fais pas ChatGPT, Compréhension pas finie)
function CreateReport {
    # Obtenir des informations sur le système
    $systemInfo = @{
        "Nom de l'ordinateur" = $env:COMPUTERNAME
        "OS"                  = (Get-CimInstance Win32_OperatingSystem).Caption
        "Processeur"          = (Get-CimInstance Win32_Processor).Name
        "Architecture CPU"    = (Get-CimInstance Win32_Processor).AddressWidth
        "Nombre de cœurs"     = (Get-CimInstance Win32_Processor).NumberOfCores
        "Nombre de threads"   = (Get-CimInstance Win32_Processor).NumberOfLogicalProcessors
        "Mémoire physique (GB)" = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object Capacity -Sum).Sum / 1GB, 2)
        "Espace total du disque (GB)" = [math]::Round((Get-CimInstance Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | Measure-Object Size -Sum).Sum / 1GB, 2)
        "Espace libre du disque (GB)" = [math]::Round((Get-CimInstance Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | Measure-Object FreeSpace -Sum).Sum / 1GB, 2)
        "Version .NET installée" = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' -Name Version).Version
        "Liste des programmes installés" = (Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher | Format-Table -AutoSize | Out-String).Trim()
    }

    # Chemin du fichier de rapport CSV
    $baseFilePath = "C:\Users\EtmlPowershell\Desktop\RapportSysteme.csv"
    $csvFilePath = $baseFilePath

    # Vérifier si le fichier CSV existe déjà
    $counter = 1
    while (Test-Path $csvFilePath) {
        $csvFilePath = $baseFilePath -replace '\.csv$', "_$counter.csv"
        $counter++
    }

    # Créer un objet CSV avec les informations sur le système
    $systemReport = New-Object PSObject -Property $systemInfo

    # Exporter le rapport CSV
    $systemReport | Export-Csv -Path $csvFilePath -NoTypeInformation

    Write-Host "Le rapport a été généré avec succès : $csvFilePath"
    Pause
}

# Fonction pour afficher le menu de l'Option 3
function ShowMenuOption3 {
    Clear-Host
    Write-Host "Option 3 : Gestion de services"
    Write-Host "1. Afficher les serveurs actifs"
    Write-Host "0. Quitter option 3"
}

# Fonction pour obtenir la liste des services actifs (Pas fini, manque la désactivation, l'activation,...)
function GetActiveServices {
    $activeServices = Get-Service | Where-Object { $_.Status -eq 'Running' }

    if ($activeServices.Count -gt 0) {
        Write-Host "Services actifs :"
        $activeServices | Format-Table DisplayName, ServiceName, Status -AutoSize
        Pause
    } 
    else {
        Write-Host "Aucun service actif trouvé."
        Pause
    }
}

# Variable pour contrôler la boucle principale du menu
$continue = $true

# Boucle principale du menu interactif
while ($continue) {
    Clear-Host
    Write-Host "Quelle option choisissez-vous ?"
    Write-Host "1. Effectuer des opérations de fichiers et répertoires"
    Write-Host "2. Générer des rapports sur l'état du système"
    Write-Host "3. Gestion de services"
    Write-Host "0. Quitter le menu"

    $choice = Read-Host "Faites votre choix"
    
    switch ($choice) {
        1 {
            do {
                ShowMenuOption1
                $FirstChoice = Read-Host "Faites votre choix"
            
                switch ($FirstChoice) {
                    1 { DirectoryManagement }
                    2 { FileManagement }
                    0 {  }
                    default { Write-Host "Choix non valide" }
                }
                
            } while ($FirstChoice -ne 0)                    
        }

        2 {
            do {
                ShowMenuOption2
                $FisrtChoice = Read-Host "Faites votre choix"
            
                switch ($FisrtChoice) {
                    1 { CreateReport }
                    0 {  }
                    default { Write-Host "Choix non valide" }
                }
                
            } while ($FisrtChoice -ne 0)
        }

        3 {
            do {
                ShowMenuOption3
                $FisrtChoice = Read-Host "Faites votre choix"
            
                switch ($FisrtChoice) {
                    1 { GetActiveServices }
                    0 {  }
                    default { Write-Host "Choix non valide" }
                }
                
            } while ($FisrtChoice -ne 0)
        }

        0 {
            $continue = $false
            Clear-Host
        }
    }
}
