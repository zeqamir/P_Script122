<#
.NOTES
Nom du fichier    : ScriptMenuProjet.ps1
Prérequis         : PowerShell 7.4.0
Version du script : 1.0
Auteur            : Amir Zeqiri
Date de creation  : 13.12.2023
Lieu              : ETML, Sébeillion
Changement        : Aucun
 
.SYNOPSIS
Adds a file name extension to a supplied name.
 
.DESCRIPTION
Adds a file name extension to a supplied name.
Takes any strings for the file name or extension.
 
.PARAMETER name
-
 
.INPUTS
-
 
.OUTPUTS
-
 
.EXAMPLE
 ./ScriptMenuProjet.ps1

.LINK
-

#>

$continue = $true
while ($continue) {
    clear-host
    write-host “Quelle option choisissez-vous ? `n1 Option 1 `n2 Option 2 `n3 Option 3 `n0 Quitter le menu"

    $choice = read-host “Faites votre choix”
    switch ($choice) {
        1 {
            function ShowMenuOption1 {
                Clear-Host
                Write-Host "Option 1"
                Write-Host "1. Gérer un répertoire"
                Write-Host "2. Gérer un fichier"
                Write-Host "0. Quitter option 1"
            }
            
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
                }
            }
            
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
                }
            }
            
            
            do {
                ShowMenuOption1
                $FisrtChoice = Read-Host "Faites votre choix"
            
                switch ($FisrtChoice) {
                    1 { DirectoryManagement }
                    2 { FileManagement }
                    0 {  }
                    default { Write-Host "Choix non valide" }
                }
                Pause
            } while ($FisrtChoice -ne 0)
                               
        }

        2 {
            function ShowMenuOption2 {
                Clear-Host
                Write-Host "Option 2"
                Write-Host "1. Générer un rapport sur l'état du système"
                Write-Host "0. Quitter option 2"
            }
            
            function AFaire {
                Write-Host "A Faire"
            }
            
            do {
                ShowMenuOption2
                $FisrtChoice = Read-Host "Faites votre choix"
            
                switch ($FisrtChoice) {
                    1 { AFaire }
                    0 {  }
                    default { Write-Host "Choix non valide" }
                }
                Pause
            } while ($FisrtChoice -ne 0)
        }

        3 {
            function ShowMenuOption3 {
                Clear-Host
                Write-Host "Option 3"
                Write-Host "1. à choisir"
                Write-Host "0. Quitter option 3"
            }
            
            function ToChoose {
                Write-Host "A choisir"
            }
            
            do {
                ShowMenuOption3
                $FisrtChoice = Read-Host "Faites votre choix"
            
                switch ($FisrtChoice) {
                    1 { ToChoose }
                    0 {  }
                    default { Write-Host "Choix non valide" }
                }
                Pause
            } while ($FisrtChoice -ne 0)
        }

        0 {
            $continue = $false
            Clear-Host
        }
    }
}
