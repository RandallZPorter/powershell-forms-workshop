$form = New-Object System.Windows.Forms.Form
$form.Width = 800                    #form width (in pixels)
$form.Height = 600                   #form height (in pixels)
$form.TopMost = $true                #makes the window appear in front of all other windows
$form.MaximizeBox = $false           #disables the maximize button
$form.FormBorderStyle = 'Fixed3D'    #Fixed3D prevents the window from being resized
$form.text = "PowerShell Workshop"   #the name to display in the title bar
$form.StartPosition = 'CenterScreen' #where the window will appear
$form.BackColor = "#1A1A1A"          #can also use names, such as "black"

<#
$imagePath = "c:\Users\s524409\Desktop\powershellTutorial\background.jpg"
$Image = [system.drawing.image]::FromFile($imagePath)
$form.BackgroundImage = $Image
$form.BackgroundImageLayout = "Stretch"
#>

Function newButton($locX, $locY, $sizeW, $sizeH, $label, $onClick) { 
    $Button = New-Object System.Windows.Forms.Button
    $Button.Location = New-Object System.Drawing.Point($locX, $locY) 
    $Button.Width = $sizeW ; $Button.Height = $sizeH
    $Button.Text = $label
    $Button.BackColor = 'white'
    $Button.Add_Click($onClick)
    return $Button
}

$button1 = newButton 265 100 90 40 'To ASCII' { 
    $textBox.Text = -join[char[]][System.Convert]::FromBase64String($textBox.Text)
} ; $form.Controls.Add($button1) 

$button2 = newButton 375 100 90 40 'To Base-64' { 
    $textBox.Text = [System.Convert]::ToBase64String([char[]]$textBox.Text)
} ; $form.Controls.Add($button2) 

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(265, 150)
$textBox.Width = 200
$form.Controls.Add($textBox)

$form.ShowDialog()