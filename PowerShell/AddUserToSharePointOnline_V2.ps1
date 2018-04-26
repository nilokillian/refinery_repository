# Paths to SDK. Please verify location on your computer. 

#Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"  
#Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"  
########################################################################################################################################

#Global varibles 
$siteCollectionLink = " ";
$groupTitle = " ";
$email = " ";
$program = "SharePoint Online Management Shell";
$url = "https://download.microsoft.com/download/0/2/E/02E7E5BA-2190-44A8-B407-BC73CA0D6B87/SharePointOnlineManagementShell_7521-1200_x64_en-us.msi";

function AddUser () {

    $adminUPN = Read-Host -Prompt 'Input your admin account'
    $userCredential = Get-Credential -Credential $adminUPN
    $server = Read-Host -Prompt 'Input your server  name (Example https://YouTenantName-admin.sharepoint.com)'
    try { Connect-sposervice -Url $server -Credential $userCredential }
        catch { "Please check Url address or Credentials"
                 BREAK 
              }
              if (!$error){Connect-sposervice -Url $server -Credential $userCredential}
    $sites = Get-SPOSite 
    $collections = @()
    $countSiteNumber = 1;

    foreach ($site in $sites){  
        $collections += New-Object -TypeName psobject -Property @{Id=$countSiteNumber; Url=$site.Url}
        $countSiteNumber++;
    }
    Write-Host ($collections  | Format-list -Property Id, Url | Out-String) -ForegroundColor Yellow


$siteCollsectionID = Read-Host -Prompt 'Input site collection number'
foreach ($id in $collections){
   if($id.Id.ToString() -eq $siteCollsectionID){
        $siteCollectionLink = $id.Url;
        Write-Host ($siteCollectionLink + " has been selected." + " Please wait ...." ) -ForegroundColor Green
    }
}
#############################################################

$groups = Get-SPOSiteGroup -Site $siteCollectionLink
$groupCollections = @()
$countgroupNumber = 1;

foreach ($group in $groups){
    $groupCollections += New-Object -TypeName psobject -Property @{Id=$countgroupNumber; Title=$group.Title}
    $countgroupNumber++;
}

Write-Host ($groupCollections | Format-list -Property Id, Title | Out-String) -ForegroundColor Yellow
$groupCollectionsID = Read-Host -Prompt 'Input group number'

foreach ($id in $groupCollections){

   if($id.Id.ToString() -eq $groupCollectionsID){

     $groupTitle = $id.Title;
     Write-Host $groupTitle -ForegroundColor Red
   }

}

    $email = Read-Host -Prompt 'Input email address of the person you want add'
    Add-SPOUser -Site $siteCollectionLink -LoginName $email -Group $groupTitle 

}


#Install-Module SharePointPnPPowerShellOnline -AllowClobber
function IsInstalled( $program ){
    
    $x86 = ((Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall") | 
    Where-Object { $_.GetValue( "DisplayName" ) -Contains($program) } ).Length -gt 0;
  
      $x64 = ((Get-ChildItem "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall") |
        Where-Object { $_.GetValue( "DisplayName" ) -Contains($program) } ).Length -gt 0;
  
      return $x86 -or $x64;
    }
  
  


  
    if (IsInstalled($program)){
        AddUser;
        }
        else {$output = "C:\Users\$env:UserName\Downloads"
        Import-Module BitsTransfer
        Start-BitsTransfer -Source $url -Destination $output
        $MSIpackage = Get-ChildItem -Path $output -File | Where-Object {$_.Name.Contains( "SharePointOnline")}
        $msi =@($MSIpackage.Name)
        Start-Process -FilePath "$env:systemroot\system32\msiexec.exe" -ArgumentList "/i `"$msi`" /qn /passive" -Wait
        
        if(($list = Get-Module -ListAvailable *Online.SharePoint*) -eq $Null){
          
            Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
            AddUser;}
            
        
    }

    
    
  
 