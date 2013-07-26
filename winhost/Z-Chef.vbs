'
' Copyright 2013 Dean Okamura
'
' Licensed under the Apache License, Version 2.0 (the "License");
' you may not use this file except in compliance with the License.
' You may obtain a copy of the License at
'
'     http://www.apache.org/licenses/LICENSE-2.0
'
' Unless required by applicable law or agreed to in writing, software
' distributed under the License is distributed on an "AS IS" BASIS,
' WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
' See the License for the specific language governing permissions and
' limitations under the License.
'
' creates C:\cookbooks and C:\vagrant
'

Option Explicit

Dim objFSO, objFolder, objShell, objSource, objTarget
Dim vagDirectory, cooDirectory, cooZipFile, itmDirectory
Dim intOptions

vagDirectory = "C:\vagrant"
cooDirectory = "C:\cookbooks"
itmDirectory = cooDirectory & "\itmhost"
cooZipFile = "Z:\cookbooks.zip"

Set objFSO = CreateObject("Scripting.FileSystemObject")

If Not objFSO.FolderExists(cooDirectory) Then
    WScript.Echo "Create " & cooDirectory
    Set objFolder = objFSO.CreateFolder(cooDirectory)
End If
If Not objFSO.FolderExists(vagDirectory) Then
    WScript.Echo "Create " & vagDirectory
    Set objFolder = objFSO.CreateFolder(vagDirectory)
End If

If Not objFSO.FolderExists(itmDirectory) Then
    WScript.Echo "Extracting " & cooZipFile
    Set objShell = CreateObject("Shell.Application")
    Set objSource = objShell.NameSpace(cooZipFile).Items()
    Set objTarget = objShell.NameSpace(cooDirectory)
    intOptions = 4
    WScript.Echo "Installing in " & cooDirectory
    objTarget.CopyHere objSource, intOptions

    WScript.Echo "Copy files to " & vagDirectory
    Set objShell = CreateObject("WScript.Shell")
    objShell.Run "cmd /c copy Z:\*.* " & vagDirectory & " /y"

    WScript.Echo "Run Chef"
    Set objShell = CreateObject("WScript.Shell")
    objShell.Run "cmd /c " & vagDirectory & "\chef-run.bat"
End If

WScript.Quit

'
