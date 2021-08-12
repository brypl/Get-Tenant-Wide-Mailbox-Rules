Function MailboxRules-TenantWide
{
    $URL = "https://ps.outlook.com/powershell"
    
    $Credentials = Get-Credential -Message "Enter your Office 365 admin credentials"

    $EXOSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $URL -Credential $Credentials -Authentication Basic -AllowRedirection -Name "Exchange Online"

    Import-PSSession $EXOSession

    $users = (get-mailbox -resultsize unlimited).UserPrincipalName
    foreach ($user in $users)
    {
    Get-InboxRule -Mailbox $user | Select-Object MailboxOwnerID,Name,Description,Enabled,RedirectTo, MoveToFolder,ForwardTo | Export-CSV C:\Temp\365-TenancyMailboxRule.csv -NoTypeInformation -Append
    }
}