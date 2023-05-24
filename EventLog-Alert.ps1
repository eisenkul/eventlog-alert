<#
    .SYNOPSIS
    EventLog-Alert

    Ersin Isenkul
    ersinisenkul@gmail.com

    Version 1.0, May 24th, 2023

    .DESCRIPTION
    This script will generate alert mail of servers for a specific event log in last 1 hour.

    .NOTES
    Determines below variable before run the script.
    $Servers : Write your server hostname or hostnames. Example: "Server01" or "Server01","Server02"
    $EventName : Write a event log source name to retrieve specific event. Example: "MSComplianceAudit"
    $LogName : Write a log name to specify event. Example: "Application", "System", or "Security"
    $Outfile : Write a file location and file name to export e-mail outline. Example: "C:\alert.html"
    $recipient : Write a recpient address. Example: "abc@xyz.com"
    $sender : Write a sender address. Example: "admin@admin.com"
    $mailsubject : Write a subject for e-mail. Example: "Event Alert"
    $mailserver : Write smtp server address to send e-mail. Example: "smtp.localhost.com" 
    
#>

$Servers = "Server01","Server02" 
$EventName = "MSComplianceAudit" 
$LogName = "Application"
$Outfile = "C:\alert.html"
$recipient = "abc@xyz.com" 
$sender = "admin@admin.com" 
$mailsubject = "Event Alert" 
$mailserver = "smtp.localhost.com"

$time = Get-Date

    $EventObjects = foreach ($Server in $Servers)
    {

        Invoke-Command -ComputerName $Server -ScriptBlock {Get-EventLog -Source $EventName -LogName $LogName -EntryType Warning,Error -Newest 1 |select MachineName,TimeGenerated,Source,EntryType,Message }

    }

    $UpdateStatus = @()
    
    foreach ($EventObject in $EventObjects){
            
                if($time.AddHours(-1) -lt $EventObject.TimeGenerated){

                    $array = $EventObject

                    foreach ($item in $array){

                        $row = "" | Select-Object Server, Time, Event, Type, Message
                        $row.Server = $item.MachineName
                        $row.Time = $item.TimeGenerated
                        $row.Event = $item.Source
                        $row.Type = $item.EntryType
                        $row.Message = $item.Message
                        $UpdateStatus += $row
                    }
                }
    }


$header = @"
<style>

    h1 {

        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;

    }

    
    h2 {

        font-family: Arial, Helvetica, sans-serif;
        color: #000099;
        font-size: 16px;

    }

    
    
   table {
		font-size: 12px;
		border: 0px; 
		font-family: Arial, Helvetica, sans-serif;
	} 
	
    td {
		padding: 4px;
		margin: 0px;
		border: 0;
	}
	
    th {
        background: #395870;
        background: linear-gradient(#49708f, #293f50);
        color: #fff;
        font-size: 11px;
        text-transform: uppercase;
        padding: 10px 15px;
        vertical-align: middle;
	}

    tbody tr:nth-child(even) {
        background: #f0f0f2;
    }
    
    #CreationDate {

        font-family: Arial, Helvetica, sans-serif;
        color: #ff3300;
        font-size: 12px;

    }

</style>
"@

$head = "<h1>Alert</h1>"

$mailbody = $UpdateStatus | ConvertTo-Html -Fragment

$Report = ConvertTo-HTML -Body "$mailbody" -Head $header

$Report | Out-File $Outfile



$message = @{
    
    to = $recipient
    from = $sender
    subject = $mailsubject
    smtpserver = $mailserver
    bodyashtml = $true
    body = $report | Out-String
    
    }

if($UpdateStatus -ne $null){

Send-MailMessage @message
}

