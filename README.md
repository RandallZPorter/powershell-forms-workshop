# Workshop: Building Windows Forms with PowerShell
A short workshop to demonstrate the use of Windows forms with PowerShell

## Contents
This tutorial will cover the following topics:
1. Setting up an environment
1. Displaying an application window
1. Adding clickable objects
1. Linking objects to scripted events

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

## 3. Adding Clickable Objects

## 4. Linking Objects to Scripted Events




