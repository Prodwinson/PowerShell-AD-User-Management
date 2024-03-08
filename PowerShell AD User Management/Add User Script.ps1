#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(400,400)
$Form.text                       = "Form"
$Form.TopMost                    = $false

$LableName                       = New-Object system.Windows.Forms.Label
$LableName.text                  = "Name"
$LableName.AutoSize              = $true
$LableName.width                 = 25
$LableName.height                = 10
$LableName.location              = New-Object System.Drawing.Point(13,15)
$LableName.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.width                  = 208
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(68,17)
$TextBox1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ComboBox1                       = New-Object system.Windows.Forms.ComboBox
$ComboBox1.text                  = ""
$ComboBox1.width                 = 209
$ComboBox1.height                = 20
$ComboBox1.location              = New-Object System.Drawing.Point(68,53)
$ComboBox1.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ComboBox1.Items.Add("Users")
$ComboBox1.Items.Add("Manager")
$ComboBox1.Items.Add("IT")
$ComboBox1.Items.Add("Administrator")

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Add User"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(145,96)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form.controls.AddRange(@($LableName,$TextBox1,$ComboBox1,$Button1))

$Button1.Add_Click({ 
    $userName = $TextBox1.Text
    $NameInitial = $userName
    $Name = $userName
    $samAccountName = $NameInitial
    $userPrincipleName = $samAccountName + "@winson.local"
    $path = "OU=" + $ComboBox1.Text + ",OU=Sales, DC=winson, DC=local"
    $password = ConvertTo-SecureString "Password123!" -AsPlainText -force

    New-ADUser -Name $Name -SamAccountName $samAccountName -UserPrincipalName $userPrincipleName -Path $path -AccountPassword $password -Enabled $true
})

#region Logic 

#endregion

[void]$Form.ShowDialog()