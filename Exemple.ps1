# Configuration
$computers = Get-Content -Path "C:\Chem\Liste_ordinateurs.txt" # Remplacez le chemin par le fichier contenant la liste des ordinateurs

foreach ($computer in $computers) {
    Write-Host "Vérification des mises à jour pour $computer"

    # Vérification des mises à jour Windows
    $windowsUpdates = Get-HotFix -ComputerName $computer | Where-Object { $_.Description -like 'Update*' }

    if ($windowsUpdates) {
        Write-Host "Mises à jour Windows disponibles sur $computer :"
        $windowsUpdates | Format-Table -AutoSize
    } else {
        Write-Host "Aucune mise à jour Windows disponible sur $computer."
    }

    # Vous pouvez ajouter ici d'autres vérifications pour des applications spécifiques

    Write-Host "------------------------------"
}

# Fin du script
Write-Host "Vérification des mises à jour terminée."
