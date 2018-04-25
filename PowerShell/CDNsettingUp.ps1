# Connect to your tenant
Connect-SPOService -Url https://thinkitltd712-admin.sharepoint.com

#Check the status of CDN capability
Get-SPOTenantCdnEnabled -CdnType Public
Get-SPOTenantCdnEnabled -CdnType Private

#Enable CDN using default settings - -NoDefaultOrigins as optional paremetr
Set-SPOTenantCdnEnabled -CdnType Public
Set-SPOTenantCdnEnabled -CdnType Private

#Get CDN policies
Get-SPOTenantCdnPolicies -CdnType Public
Get-SPOTenantCdnPolicies -CdnType Private

#Add CDN origin
Add-SPOTenantCdnOrigin -CdnType Public -OriginUrl sites/cdn/cdn
Add-SPOTenantCdnOrigin -CdnType Private -OriginUrl sites/cdn/cdn

#Get CDN origin
Get-SPOTenantCdnOrigins -CdnType Public
Get-SPOTenantCdnOrigins -CdnType Private

#SharePoint Online a try as a public CDN, keep in mind that link is'n accessible by putting into the browser address field
https://publiccdn.sharepointonline.com/thinkitltd712.sharepoint.com/sites/cdn/cdn

#Remove CDN origin
Remove-SPOTenantCdnOrigin -CdnType Public -OriginUrl SITES/PRODUCTPORTFOLIO/CDN
Remove-SPOTenantCdnOrigin -CdnType Private -OriginUrl

#Disable CDN using default settings
Set-SPOTenantCdnEnabled -CdnType Public -Enable $false
Set-SPOTenantCdnEnabled -CdnType Private -Enable $false