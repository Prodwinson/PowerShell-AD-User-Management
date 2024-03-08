# creates a new user with password. Change all the variables to fit your need.
$userName = "john" 
$samName = "jdoe"
$PrincipleName = "jdoe@winson.local"
$path = "OU=Managers, OU=Sales, DC=winson, DC=local"
$password = ConvertTo-SecureString "Password123!" -AsPlainText -force

New-ADUser -Name $userName -SamAccountName $samName -UserPrincipalName $PrincipleName -Path $path -AccountPassword $password -enabled $true

# Change $true to $false if you want to disable the user account
Set-ADUser -Identity $samName -Enabled:$true

# Resetting password for user accounts and changing password at logon
$NewPassword = "Newpassword123"
Set-ADAccountPassword -Identity $samName -Reset -NewPassword (ConvertTo-SecureString $NewPassword -AsPlainText -Force)
Set-ADUser -Identity $samName -ChangePasswordAtLogon $true

# Creating groups and assigning group members
$groupName = "IT"
New-ADGroup -Name $groupName -Path $path -GroupScope Global
Add-ADGroupMember -Identity $groupName -Members $samName