
$usercreation = @{
    '-Name'="ICT-beheer-User";
    'GivenName'="ICT-beheer-User";
    'UserPrincipalName'="ictbeheeruser";
    'SamAccountName'="ictbeheeruser";
    'EmailAddress'="ictbeheeruser@drieseng.hanze27"
    'AccountPassword'=(ConvertTo-SecureString "Dhanze27" -AsPlainText -Force);
    'Path'=Get-ADOrganizationalUnit -Filter "Name -eq 'Medewerkers'" | Select-Object -ExpandProperty DistinguishedName;
    'Enabled'=$true
 }

New-ADUser @usercreation
Add-ADGroupMember -Identity "Helpdeskmedewerkers" -Members "ictbeheeruser"
