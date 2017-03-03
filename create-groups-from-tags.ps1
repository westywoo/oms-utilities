# to use a profile, setup a service principal as follows
# https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authenticate-service-principal
Select-AzureRmProfile -Path C:\Users\miwestaw\Data\azure\MyAzureRmProfile20170227.json
# alternatively..
# Login-AzureRmAccount

# TODO configure OMS Workspace name and resource group here
$wn="mike-demo" # from the Portal, Log Analytics
$rg = "mms-weu" # from the Portal, Log Analytics

# TODO define the output file and folder here
$cwd = "C:\Users\miwestaw\Data\azure\"
$cmdscript = "my-create-groups-script.ps1"

# TODO set your category here
$groupCategory="My Computer Groups"

##################################

$groups = Get-AzureRmResourceGroup

# to work with tags 
# https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags

$etag=Get-Date -Format yyyy-MM-ddThh:mm:ss.msZ

# these are examples that will be set lower down
# see https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-log-search-api
#
#$groupName="My Computer Group"
#$groupQuery = "Computer=*jump* | Distinct Computer"
#$groupCategory="My Computer Groups"
#$groupID = "My Computer Groups | My Computer Group"
#$groupJson = "{'etag': 'W/`"datetime\'" + $etag + "\'`"', 'properties': { 'Category': '" + $groupCategory + "', 'DisplayName':'"  + $groupName + "', 'Query':'" + $groupQuery + "', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"

# A Hastable of group name keys, each value is itself an ArrayList of values for that group
$ght = @{}

foreach ($g in $groups) {
    $resources = Find-AzureRmResource -ResourceGroupNameEquals $g.ResourceGroupName
    foreach ($r in $resources) {
        # currently working with VirtualMachines - add extra types to this if {}
        if ($r.ResourceType.Equals("Microsoft.Compute/virtualMachines")) {
            if (!$r.tags.keys.Count.Equals(0)) { # only work with tagged VMs..
                "=============="
                $r.Name
                $r.ResourceType
                $r.tags.keys.Count
                foreach ($key in $r.tags.keys) {
                    $htKey = $key + "_" + $r.tags.Get_Item($key)
                    #$htValue = $r.name
                    $htvalue = (Get-azurermvm -ResourceGroupName $g.ResourceGroupName -name $r.name).OSProfile.ComputerName
                    if ($ght.ContainsKey($htKey)) {
                        # add the value to this key
                        $valuesList = $ght.get_item($htKey)
                        $valuesList.add($htValue)
                        $ght.set_item($htKey, $valuesList)
                    }
                    else {
                        $valuesList = New-Object System.Collections.ArrayList
                        $valuesList.add($htValue)
                        $ght.add($htKey, $valuesList)
                    }
                }
                "--------------"
            }
        }
    }
}

# my example $ght
#Name                           Value                                                                                                           
#----                           -----                                                                                                           
#displayName_NetscalerVM        {XA-NetScaler}                                                                                                  
#displayName_VdaVM              {XA-VDA, XA-VDI}                                                                                                
#displayName_ControllerVM       {XA-Controller}                                                                                                 
#displayName_JumpBoxVM          {XA-JumpBox}                                                                                                    
#displayName_JumpBox            {JumpBox}                                                                                                       
#environment_PREPROD            {JumpBox}                                                                                                       
#displayName_DomainControllerVM {XA-DC}                                                                                                         
#owner_miwestaw                 {JumpBox}                                                                                                       

$filename = $cwd + $cmdscript
out-file $filename

foreach ($key in $ght.Keys) {
  $valueList = $ght.get_item($key)
  $valuesJson = ""
  foreach ($value in $valueList) {
    if (!$valuesJson.Equals("")) { $valuesJson += "," }
    $valuesJson += $value
  }

  # now create the group JSON
  # https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-log-search-api

  $groupName=$key
  $groupQuery = "Computer IN {"+$valuesJson+"} | distinct Computer"
  $groupID = $groupCategory + " | " + $groupName
  # note the use of single quotes so that the backtick is passed through literally
  $groupJson = "{'etag': 'W/"+'`"' + "datetime\'" + $etag + "\'" + '`"' + "', 'properties': { 'Category': '" + $groupCategory + "', 'DisplayName':'"  + $groupName + "', 'Query':'" + $groupQuery + "', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"
  #$groupJson = "{'etag': 'W/`"datetime\'" + $etag + "\'`"', 'properties': { 'Category': '" + $groupCategory + "', 'DisplayName':'"  + $groupName + "', 'Query':'" + $groupQuery + "', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"
  #$groupJson = "{'properties': { 'Category': '" + $groupCategory + "', 'DisplayName':'"  + $groupName + "', 'Query':'" + $groupQuery + "', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"

  # write the JSON to a file
  #$jsonFilePathname = $cwd + $groupName +".json"
  #$groupJson | ConvertTo-Json -depth 100 | Out-File $jsonFilePathname

  # write the command to create the groups using these json files..
  # https://github.com/projectkudu/ARMClient

  $subscriptionid = (get-AzureRmSubscription).SubscriptionId

  # write the commans to file so they can be checked before execution
  '$groupId="'+$groupId+'"' | Out-File -Append $filename
  '$groupJson="'+$groupJson+'"' | Out-File -Append $filename
  # note the use of single quote to allow $groupId and $groupJson string to be literally written to the file
  "armclient put /subscriptions/"+$subscriptionid+"/resourceGroups/"+$rg+"/providers/Microsoft.OperationalInsights/workspaces/"+$wn+'/savedSearches/$groupID`?api-version=2015-03-20 $groupJson' | Out-File -Append $filename
  ' ' | Out-File -Append $filename
}
