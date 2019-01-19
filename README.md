# Workshop: Building Windows Forms with PowerShell
A short workshop to demonstrate the use of Windows forms with PowerShell

## Contents
This tutorial will cover the following topics:
1. Setting up an environment
1. Displaying an application window
1. Adding clickable objects and events (We will focus mostly on buttons)

## 1. Setting up an Environment
We will be doing this development in the Powershell Integrated Scripting Environment (ISE). The easiest way to get to it is by doing a start menu search for "powershell," then clicking on the "PowerShell ISE" result:

![PowerShell ISE](https://github.com/RandallZPorter/powershell-forms-workshop/raw/master/open_ise.PNG "Finding the ISE")

If you opened the right program, you should see this window:
![PowerShell ISE](https://github.com/RandallZPorter/powershell-forms-workshop/raw/master/empty_ise.PNG "Finding the ISE")
You may want to save your file before you start working. This will protect it from loss and allow you to name it.

An important note: PowerShell has a system of "Execution Policies" that behave strangely sometimes. If your code does not run, you may need to adjust your execution policy.



## 2. Displaying an Application Window

### Creating
The first line of code will create an instance of a Windows Form, which can be displayed on the screen by calling the second line. The cast to void is because the ShowDialog() method returns a string, which will be echoed to the console. Casting to void will hide it.
```powershell
$form = New-Object System.Windows.Forms.Form
[void] $form.ShowDialog()
```
$form.ShowDialog() is going to be the last line of our program throughout this workshop. Any code we add is going to go above it.

### Customizing
Now we can add some additional code to modify how our window will look. Currently it should look something like this:

![PowerShell ISE](https://github.com/RandallZPorter/powershell-forms-workshop/raw/master/first_window.PNG "The default window")

Some simple things we may way to customize about our window include:
- Default size
- Default location
- Background color or image
- Window Title

The following code will create an 800x600 pixel window, centered in the screen, with the title "PowerShell Workshop," and the same background color as this page. It will not be resizeable, and it will always be the topmost window.
```powershell
$form = New-Object System.Windows.Forms.Form
$form.Width = 800                    #form width (in pixels)
$form.Height = 600                   #form height (in pixels)
#$form.Size = New-Object System.Drawing.Size(800,600)  #another way to set size
$Form.TopMost = $true                #makes the window appear in front of all other windows
$Form.MaximizeBox = $false           #disables the maximize button
$Form.FormBorderStyle = 'Fixed3D'    #Fixed3D prevents the window from being resized
$form.text = "PowerShell Workshop"   #the name to display in the title bar
$form.StartPosition = 'CenterScreen' #where the window will appear
$form.BackColor = "#1A1A1A"          #can also use names, such as "black"

[void] $form.ShowDialog()
```
These are just a few of the customization options available. You can make your window look however you want. Mine currently looks like this:
![PowerShell ISE](https://github.com/RandallZPorter/powershell-forms-workshop/raw/master/custom_window.PNG "Custom Window")

Unfortunately, setting a picture as a background image is a little bit more difficult. We have to tell the script where our image is located. I used an absolute path for mine, but you can use relative paths if you want to. Unless your image is a perfect fit for your window, you may also want to control how it is positioned on the screen. Powershell accepts similar fit settings as Windows does for setting backgrounds: "Stretch," "Tile," and "Center."
```powershell
$imagePath = "c:\Users\s524409\Desktop\powershellTutorial\background.jpg"
$Image = [system.drawing.image]::FromFile($imagePath)
$form.BackgroundImage = $Image
$form.BackgroundImageLayout = "Stretch"
```
I specified a Matrix-like image for my background. Now my window looks like this:

![PowerShell ISE](https://github.com/RandallZPorter/powershell-forms-workshop/raw/master/custom_background.PNG "Custom Window")

Once you are happy with how your window looks, we can move on to learning how to add buttons, fields, and other things.


## 3. Adding Clickable Objects (Actually just buttons)
There are several kinds of objects we can add to our window. Let's talk about some of them.

### Buttons
We will look at buttons first. Every button has a few attributes. These are the most important:
- Size (Length and width)
- Label
- Position (Measured in pixels from the top-left corner of the window)
- Color

Let's add a button in the top left corner of our screen. First, we need to specify some functionality for our button. For our first button, let's make it print "Hello, World!" when clicked. Of course, you can make it do whatever you want.
```powershell
function onClick1 {
    Write-Host "Hello, World!"
}
```
Now we can make the button itself:
```powershell
$button1 = New-Object System.Windows.Forms.Button 
$button1.Location = New-Object System.Drawing.Size(30,30) 
$button1.Size = New-Object System.Drawing.Size(90,40) 
$button1.Text = "Hello!" 
$button1.BackColor = 'white'
```
Now we need to bind the function, and attach our new button to our window:
```powershell
$button1.Add_Click({onClick1}) 
$form.Controls.Add($button1) 
```
That was pretty tedious just to create one button. The following function can be used as a constructor to make this easier:
```powershell
Function newButton($locX, $locY, $sizeW, $sizeH, $label, $onClick) { 
    $Button = New-Object System.Windows.Forms.Button
    $Button.Location = New-Object System.Drawing.Point($locX, $locY) 
    $Button.Width = $sizeW ; $Button.Height = $sizeH
    $Button.Text = $label
    $Button.BackColor = 'white'
    $Button.Add_Click($onClick)
    return $Button
}
```
With this function, we can make our buttons much more easily. Let's rewrite our original button using this new function:
```powershell
$button1 = newButton 30 30 90 40 'Hello!' { 
    Write-Host "Hello, World!"
} ; $form.Controls.Add($button1) 
```
Our code now looks like this:

```powershell
$form = New-Object System.Windows.Forms.Form
$form.Width = 800                    #form width (in pixels)
$form.Height = 600                   #form height (in pixels)
$form.TopMost = $true                #makes the window appear in front of all other windows
$form.MaximizeBox = $false           #disables the maximize button
$form.FormBorderStyle = 'Fixed3D'    #Fixed3D prevents the window from being resized
$form.text = "PowerShell Workshop"   #the name to display in the title bar
$form.StartPosition = 'CenterScreen' #where the window will appear
$form.BackColor = "#1A1A1A"          #can also use names, such as "black"

$imagePath = "c:\Users\s524409\Desktop\powershellTutorial\background.jpg"
$Image = [system.drawing.image]::FromFile($imagePath)
$form.BackgroundImage = $Image
$form.BackgroundImageLayout = "Stretch"

Function newButton($locX, $locY, $sizeW, $sizeH, $label, $onClick) { 
    $Button = New-Object System.Windows.Forms.Button
    $Button.Location = New-Object System.Drawing.Point($locX, $locY) 
    $Button.Width = $sizeW ; $Button.Height = $sizeH
    $Button.Text = $label
    $Button.BackColor = 'white'
    $Button.Add_Click($onClick)
    return $Button
}

$button1 = newButton 30 30 90 40 'Hello!' { 
    Write-Host "Hello, World!"
} ; $form.Controls.Add($button1) 

$form.ShowDialog()
```
And our window should look something like this:

![PowerShell ISE](https://github.com/RandallZPorter/powershell-forms-workshop/raw/master/window_with_button.PNG "Custom Window")

### Text Fields
Adding text fields is very similar to our original code for adding buttons:
```powershell
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(100, 100)
$form.Controls.Add($textBox)
```

### Linking Buttons and Text Fields
Let's do something useful with the objects on our screen. I'm going to turn mine into an encoder. First let's relocate and rename our objects, and add another button. The code for my buttons and text box is now this:
```powershell
$button1 = newButton 265 100 90 40 'To ASCII' { 
} ; $form.Controls.Add($button1) 

$button2 = newButton 375 100 90 40 'To Base-64' { 
} ; $form.Controls.Add($button2) 

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(265, 150)
$textBox.Width = 200
$form.Controls.Add($textBox)
```
And my window now looks like this:

![PowerShell ISE](https://github.com/RandallZPorter/powershell-forms-workshop/raw/master/textbox_and_button.PNG "Custom Window")

When my button is clicked, I want it to convert between base-64 encoding and plain text. In the code block for the button's click, we will make a reference to the text box. Here is the final code for the entire project:
```powershell
$form = New-Object System.Windows.Forms.Form
$form.Width = 800                    #form width (in pixels)
$form.Height = 600                   #form height (in pixels)
$form.TopMost = $true                #makes the window appear in front of all other windows
$form.MaximizeBox = $false           #disables the maximize button
$form.FormBorderStyle = 'Fixed3D'    #Fixed3D prevents the window from being resized
$form.text = "PowerShell Workshop"   #the name to display in the title bar
$form.StartPosition = 'CenterScreen' #where the window will appear
$form.BackColor = "#1A1A1A"          #can also use names, such as "black"

$imagePath = "c:\Users\s524409\Desktop\powershellTutorial\background.jpg"
$Image = [system.drawing.image]::FromFile($imagePath)
$form.BackgroundImage = $Image
$form.BackgroundImageLayout = "Stretch"

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
```

The end.
