# Workshop: Building Windows Forms with PowerShell
A short workshop to demonstrate the use of Windows forms with PowerShell

##Contents
This tutorial will cover the following topics:
1. Setting up an environment
1. Displaying an application window
1. Adding clickable objects
1. Linking objects to scripted events

##1. Setting up an Environment
We will be doing this development in the Powershell Integrated Scripting Environment (ISE). The easiest way to get to it is by doing a start menu search for "powershell," then clicking on the "PowerShell ISE" result:
![Search for the Powershell ISE](https://github.com/RandallZPorter/powershell-forms-workshop/blob/master/open_ise.PNG "Finding the ISE")

If you opened the right program, you should see this window:
![Search for the Powershell ISE](https://github.com/RandallZPorter/powershell-forms-workshop/blob/master/empty_ise.PNG "Finding the ISE")
You may want to save your file before you start working. This will protect it from loss and allow you to name it.

An important note: PowerShell has a system of "Execution Policies" that behave strangely sometimes. If your code does not run, you may need to adjust your execution policy.

##2. Displaying an Application Window

```PowerShell
$form = New-Object System.Windows.Forms.Form
[void] $form.ShowDialog()
```

##3. Adding Clickable Objects

##4. Linking Objects to Scripted Events
