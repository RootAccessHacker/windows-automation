$name = Read-Host "Enter the username you want to create"
$pass = Read-Host -AsSecureString "Enter a password"
$check = Read-Host -AsSecureString "Re-enter password"
$pass_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass))
$check_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($check))


if ($pass_text -ceq $check_text) {
    $usercreation = @{
    '-Name'= $name;
    'GivenName'=$name;
    'UserPrincipalName'= $name.ToLower();
    'SamAccountName'= $name.ToLower();
    'EmailAddress'=$name.ToLower() + "@drieseng.hanze27";
    'AccountPassword'=$pass;
    'Path'=Get-ADOrganizationalUnit -Filter "Name -eq 'Medewerkers'" | Select-Object -ExpandProperty DistinguishedName;
    'Enabled'=$true
    }
    try {
        New-ADUser @usercreation
        Add-ADGroupMember -Identity "Helpdeskmedewerkers" -Members $name.tolower()
    }
    catch{
        echo ""
        echo "Password does not meet complexity requirements."
    }
}
else {
    echo "Passwords do not match."
}
