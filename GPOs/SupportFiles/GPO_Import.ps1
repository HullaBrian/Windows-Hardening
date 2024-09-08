##########################################################################################################################
#
# Author       - David L Foster
# Date Written - August 06, 2020
# Descriptions - Import GPO backup to an AD envirnoment. Prompts user for import file. Checks for existance of GPO in
#                AD environment. If present, prompts user to overwrite existing GPO.
#                This script can be used to input any GPO backups to any AD environment. User must update the input
#                files and migration table prior to executing script. A sample migration table should be located under 
#                DISA STIG Baseline Package Support Files 
#
##########################################################################################################################
Param([Parameter(Mandatory=$false)]$gpoimportFile, [Parameter(Mandatory=$false)]$importtable)
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic
#Add-Type -AssemblyName System.Speech
#$Speak = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer

#imports required module
import-module grouppolicy
#Setting script variables
$date = Get-Date
$myfolder = [Environment]::GetFolderPath("MyDocuments")
$logfolder = $myfolder + "\GPO_Automation_Logs"
$logfile = $logfolder + "\STIG_GPO_Import.log"

<#
Function Check-Audio{
Try{
    $speak.speak('')
} Catch {
    #Write-Warning "No audio device"
    $Skipspeak = "False"
    }
Return $skipspeak
}
#>

#Function used to write to log file
Function Write-Log($output){
    Out-File -Filepath $logfile -InputObject $output -Append
}

#Function used to obtain files
Function Get-Filename(){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $openfiledialog = New-Object System.Windows.Forms.OpenFileDialog
    $openfiledialog.InitialDirectory = $myfolder
    $openfiledialog.ShowDialog() | Out-Null
    $openfiledialog.FileName
    if($openfiledialog.FileName -eq ""){
        Write-Warning "Exiting Script. Press any key to continue..."
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        Exit
    }

}

#Function to verify log file exist.
Function Get-Logfile{
    Write-Host "Checking for Log file"
   #Checking for the the log directory and log file. 
    If(Test-Path $logfolder){
        #Checking if log file exist
        If(Test-Path $logfile){
            #if($skipspeach -ne "False"){
                #$speak.speak('Log file was located')
            #}
            Write-Host "$logfile was located"
            $logfilefound = "$logfile was located $date"
            Write-Log $logfilefound
        } else {
            #if($skipspeach -ne "False"){
                #$speak.speak('Log file was not found. We will now create.')
            #}
            Write-Host "$logfile was not present. We will now create"
            $logfilecreate = "$logfile was not present. We will now create $date"
            Write-Log $logfilecreate
        }
    } else {
        #if($skipspeach -ne "False"){
                #$speak.speak('Log folder was not found. We will now create.')
            #}
        Write-Host "$logfolder was not found. We will now create"
        $createlogfolder = "$logfolder was not found. We will now create $date"
        New-Item $logfolder -type directory -Force
        Write-Log $createlogfolder
        $logfilecreate = "$logfile was not found. We will now create $date"
        Write-Log $logfilecreate
    }
}

#Function will loop through GPO input file. Will check for exitance of GPO and prompt user to overwrite. If not present GPO is created
Function Import-DISAGPO($importfile, $migrationtable, $logfile){
    #logging source file and date
    $importfile, $migrationtable, $date | Out-File -FilePath $logfile
    if($migrationtable -eq $null){
        #Selecting migration table to be used in GPO import. Sample migration table provide DISA STIG Baseline Package Support Files 
        #if($skipspeach -ne "False"){
            #$speak.speak('Select migration table file. File is available in DISA quarterly baseline support files directory.')
        #}
        Write-Host "Select migration table file. File is available in DISA quarterly baseline support files directory."
        $migrationtable = Get-Filename
    }

    #Import and loops through each line in import file
    $gpolist = import-csv -Path $importfile -ErrorAction Stop 
    Foreach($gpo in $gpolist){
        #Checking if the GPO already exist
        #if($skipspeach -ne "False"){
            #$speak.speak($gpo.gponame)
        #}
        Write-Host $gpo.gponame
        
        $locate = Get-GPO -Name $gpo.gponame -ErrorAction SilentlyContinue
        if($locate.DisplayName -eq $null){
            #If GPO does not exist the GPO is imported to AD environment
            #if($skipspeach -ne "False"){
                #$speak.speak('GPO not found. We will create and import GPO.')
            #}
            Write-Host "No GPO named" $gpo.gponame "was found. We will now create and import GPO."
            $gpogponame = $gpo.gponame
            $gpoimportresults = "No GPO named $gpogponame was present. $gpogponame was created and settings imported."
            #Importing GPO from backup.
            Import-GPO -BackupGpoName $gpo.gponame -Path $gpo.path -TargetName $gpo.gponame -CreateIfNeeded -MigrationTable $migrationtable
            Write-Log $gpoimportresults
        } else {
            #If GPO does exist notifies user and prompts to overwrite
            #if($skipspeach -ne "False"){
                #$speak.speak('GPO found')
            #}
            Write-Host "GPO named" $locate.DisplayName "was found"
            $gpodisplayname = $locate.DisplayName
            #if($skipspeach -ne "False"){
                #$speak.speak('Do you want to overwrite existing GPO?')
            #}
            $userinput = Read-Host "Do you want to overwrite existing GPO" $locate.DisplayName "(Y/N)"
            if($userinput.ToUpper() -eq 'Y'){
                #if($skipspeach -ne "False"){
                    #$speak.speak('We will overwrite existing GPO.')
                #}
                Write-Host "We will overwrite existing GPO" $locate.DisplayName
                #Importing GPO from backup. Migration table is predefined. User must update table before excution of script
                Import-GPO -BackupGpoName $gpo.gponame -Path $gpo.path -TargetName $gpo.gponame -CreateIfNeeded -MigrationTable $migrationtable
                $gpooverwrite = "$gpodisplayname was overwritten with GPO backup"
                Write-Log $gpooverwrite
            } else {
                #GPO is not imported.
                #if($skipspeach -ne "False"){
                    #$speak.speak('The GPO was not overwritten')
                #}
                Write-Host "The GPO" $locate.DisplayName "was not overwritten"
                $gponooverwrite = "$gpodisplayname was not overwritten"
                Write-Log $gponooverwrite
            }
       }
    }
}

#Function used to determine import file prepared
Function Get-Importfile($gpoimportFile, $importtable){        
    #Ensuring user has modifed import file
    #if($skipspeach -ne "False"){
        #$speak.speak('Message box, Have you made all required updates to import files? Yes No Cancel')
    #} 
    $msgBoxInput = [System.Windows.Forms.MessageBox]::Show('Have you made all required updates to import file?','DISA Import File Updates','YesNoCancel','Question')
        switch ($msgBoxInput){
            'Yes'{
                if($gpoimportFile -eq $null){
                    #if($skipspeach -ne "False"){
                        #$speak.speak('Select GPO import file. File is available in DISA quarterly baseline support files directory.')
                    #}
                    Write-Host "Select GPO import file. File is available in DISA quarterly baseline support files directory."
                    $importfile = Get-Filename
                    Write-Host $importfile
                    Import-DISAGPO $importfile $importtable $logfile
                } else {
                    Import-DISAGPO $gpoimportFile $importtable $logfile
                }
            }
            'No'{
                #if($skipspeach -ne "False"){
                    #$speak.speak('You must complete prework before executing script. No changes made to environment.')
                #}
                Write-Warning "You must complete prework before executing script. Please make all required updates to import files available within DISA STIG Baseline Package Support Files. Script will exit"
                $prework = "You must complete prework before executing script. No changes made to environment."
                Write-Log $prework
                Exit
                }
            'Cancel'{
                #if($skipspeach -ne "False"){
                   #$speak.speak('No changes made. Script was canceled.')
                #}
                Write-Warning "Closing script..."
                $prework = "No changes made. Script was canceled."
                Write-Log $prework
                Exit
            }
        }
 }

<#
$skipspeach = Check-Audio
if($skipspeach -eq "False"){
    Get-Logfile
    if($gpoimportFile -eq $null -or $importtable -eq $null){
        Get-Importfile $gpoimportFile $importtable
    } else { 
        Import-DISAGPO $gpoimportFile $importtable $logfile
    }
} else {
#>
    #$speak.speak('Checking for log files.')
    Get-Logfile
    if($gpoimportFile -eq $null -or $importtable -eq $null){
        #$speak.speak('Requesting import files.')
        Get-Importfile $gpoimportFile $importtable
    } else { 
        Import-DISAGPO $gpoimportFile $importtable $logfile
    }


