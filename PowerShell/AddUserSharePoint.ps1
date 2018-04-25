# Paths to SDK. Please verify location on your computer. 

Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"  

Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"  

########################################################################################################################################





$server = Read-Host -Prompt 'Input your server  name (Example https://YouTenantName-admin.sharepoint.com)'

Connect-PnPOnline -Url $server 

Connect-PnPOnline -Url https://easthealtheasttrust-admin.sharepoint.com

###################################################################################################################

$siteCollectionLink = " ";

$groupTitle= " ";

$email = " ";

$sites = Get-SPOSite 

$collections = @()

$count = 1;

foreach ($site in $sites){  

    $collections += New-Object -TypeName psobject -Property @{Id=$count; Url=$site.Url}

    $count++;

}

Write-Host ($collections  | Format-list -Property Id, Url | Out-String) -ForegroundColor Yellow

############################################################################

$siteCollsectionID = Read-Host -Prompt 'Input site collection number'

foreach ($id in $collections){



   if($id.Id.ToString() -eq $siteCollsectionID){



    $siteCollectionLink = $id.Url;

    Write-Host ($siteCollectionLink + " has been selected" + " Please wait ...." ) -ForegroundColor Green



   }

}

#############################################################



ClientContext client = new ClientContext("SiteURL");



Web web = client.Web;

Group group = web.SiteGroups.GetByName("test Members");

User user = web.EnsureUser("mydomain\\user"); // Note the double backslash.



// Add user to group.

group.Users.AddUser(user);

client.ExecuteQuery();

































$groups = Get-SPOSiteGroup -Site $siteCollectionLink

$groupCollections = @()

$count = 1;

foreach ($group in $groups){

    $groupCollections += New-Object -TypeName psobject -Property @{Id=$count; Title=$group.Title}

    $count++;

}

Write-Host ($groupCollections  | Format-list -Property Id, Title | Out-String) -ForegroundColor Yellow

$groupCollectionsID = Read-Host -Prompt 'Input group number'



foreach ($id in $groupCollections){

   if($id.Id.ToString() -eq $groupCollectionsID){

    $groupTitle = $id.Title;

     Write-Host $groupTitle -ForegroundColor Red

   }

}

$email = Read-Host -Prompt 'Input email address of the person you want add'

Set-SPOUser -Site $siteCollectionLink -LoginName $email -Group $groupTitle -IsSiteCollectionAdmin $true

