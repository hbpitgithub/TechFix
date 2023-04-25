Connect-ExchangeOnline  
$csv = "C:\temp\MobileDevices.csv"
$results = @()
$mailboxUsers = get-mailbox -resultsize unlimited
$mobileDevice = @()
 
foreach($user in $mailboxUsers)
{
$UPN = $user.UserPrincipalName
$displayName = $user.DisplayName
 
$mobileDevices = Get-MobileDevice -Mailbox $UPN
       
      foreach($mobileDevice in $mobileDevices)
      {
          Write-Output "Getting info about a device for $displayName"
          $properties = @{
          Name = $user.name
          UPN = $UPN
          DisplayName = $displayName
          FriendlyName = $mobileDevice.FriendlyName
          ClientType = $mobileDevice.ClientType
          ClientVersion = $mobileDevice.ClientVersion
          DeviceId = $mobileDevice.DeviceId
          DeviceAccessState = $mobileDevice.DeviceAccessState
          DeviceModel = $mobileDevice.DeviceModel
          DeviceOS = $mobileDevice.DeviceOS
          DeviceType = $mobileDevice.DeviceType
          FirstSyncTime = $mobileDevice.FirstSyncTime     
          IsDisabled = $mobileDevice.IsDisabled    
          }
          $results += New-Object psobject -Property $properties
      }
}
 
$results | Select-Object Name,UPN,FriendlyName,DisplayName,ClientType,ClientVersion,DeviceId,DeviceAccessState,DeviceModel,DeviceOS,DeviceType,FirstSyncTime,IsDisabled | Export-Csv -notypeinformation -Path $csv
 
