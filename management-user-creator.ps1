$name = Read-Host "Enter the username of the user you want to create"
$pass = Read-Host -AsSecureString "Enter a password"
$check = Read-Host -AsSecureString "Re-enter password"
$group = Read-Host "To which group should the user belong?`n[1] Administratie`n[2] Helpdeskmedewerkers`n"
$pass_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass))
$check_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($check))

if($group -eq "1"){
    $group = "Administratie"
}
elseif($group -eq "2"){
    $group = "Helpdeskmedewerkers"
}
else {
    break
}

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
        Add-ADGroupMember -Identity $group -Members $name.tolower()
    }
    catch{
        echo ""
        echo "Password does not meet complexity requirements."
    }
}
else {
    echo "Passwords do not match."
}
