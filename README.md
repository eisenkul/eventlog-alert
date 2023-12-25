# EventLog Alert

**Author:** Ersin Isenkul  
**Email:** ersinisenkul@gmail.com  
**Version:** 1.0, May 24th, 2023

## Description

This script generates an alert email for servers based on a specific event log in the last 1 hour.

## Notes

Before running the script, set the following variables:

- `$Servers`: Write your server hostname or hostnames. Example: "Server01" or "Server01", "Server02"
- `$EventName`: Write an event log source name to retrieve a specific event. Example: "MSComplianceAudit"
- `$LogName`: Write a log name to specify the event. Example: "Application", "System", or "Security"
- `$Outfile`: Write a file location and filename to export the email outline. Example: "C:\alert.html"
- `$recipient`: Write a recipient address. Example: "abc@xyz.com"
- `$sender`: Write a sender address. Example: "admin@admin.com"
- `$mailsubject`: Write a subject for the email. Example: "Event Alert"
- `$mailserver`: Write the SMTP server address to send the email. Example: "smtp.localhost.com"

## Alert Output Sample

 ![image](https://github.com/eisenkul/eventlog-alert/assets/11899703/5a727328-c29e-4ee3-983f-c6c36453b7b3)
