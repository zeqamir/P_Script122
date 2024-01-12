Install-Module -Name ImportExcel -Scope CurrentUser
Import-Csv -Path "C:\Users\EtmlPowershell\Desktop\RapportSysteme_5.csv" | Export-Excel -Path "C:\Users\EtmlPowershell\Downloads\Livre2.xlsx" -WorksheetName "Sheet1";
