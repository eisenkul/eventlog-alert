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
    
    
   **Alert Output Sample**
                                        
   ![image](https://github.com/eisenkul/eventlog-alert/assets/11899703/5a727328-c29e-4ee3-983f-c6c36453b7b3)

