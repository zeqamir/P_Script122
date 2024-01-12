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
 ./ScriptMenuProjet.ps1 -p C:\Users\EtmlPowershell\Desktop\numberingFiles

.LINK
-

#>

$continue = $true
while ($continue) {
    write-host “Que voulez-vous faire `n1 Option 1 `n2 Option 2 `n3 Option 3 `n0 Sortie"

    $choice = read-host “>”
    switch ($choice) {
        1 {
            $continue1 = $true
            while ($continue1) {
                write-host “Que voulez-vous gérer ? `n1 Fichier `n2 Répertoire 3 `n0 Sortie"

                $choice1 = read-host “>”
                switch ($choice1) {
                    1 {
                        $continue1 = $true
                        while ($continue1) {
                            write-host “Que voulez-vous faire ? `n1 Copier `n2 Supprmier `n3 Déplacer 3 `n0 Sortie"

                            $choice1 = read-host “>”
                            switch ($choice1) {
                                1 {
                                    
                                }

                                2 {

                                }

                                0 { $continue = $false }
                            }
                        }
                    }

                    2 {
                        $continue1 = $true
                        while ($continue1) {
                            write-host “Que voulez-vous faire ? `n1 Copier `n2 Supprmier `n3 Déplacer 3 `n0 Sortie"

                            $choice1 = read-host “>”
                            switch ($choice1) {
                                1 {
                        
                                }

                                2 {

                                }

                                0 { $continue = $false }
                            }
                        }
                    }

                    0 { $continue = $false }
                }
            }
        }

        2 {

        }

        3 {

        }

        0 { $continue = $false }
    }
}
