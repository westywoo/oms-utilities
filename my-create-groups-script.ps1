$groupId="My Computer Groups | displayName_NetscalerVM"
$groupJson="{'etag': 'W/`"datetime\'2017-03-03T04:20:54.2054Z\'`"', 'properties': { 'Category': 'My Computer Groups', 'DisplayName':'displayName_NetscalerVM', 'Query':'Computer IN {XA-NetScaler} | distinct Computer', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"
armclient put /subscriptions/b81adc9c-f249-4121-805c-5b6dea19b32f/resourceGroups/mms-weu/providers/Microsoft.OperationalInsights/workspaces/mike-demo/savedSearches/$groupID`?api-version=2015-03-20 $groupJson
 
$groupId="My Computer Groups | displayName_VdaVM"
$groupJson="{'etag': 'W/`"datetime\'2017-03-03T04:20:54.2054Z\'`"', 'properties': { 'Category': 'My Computer Groups', 'DisplayName':'displayName_VdaVM', 'Query':'Computer IN {XA-VDA,XA-VDI} | distinct Computer', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"
armclient put /subscriptions/b81adc9c-f249-4121-805c-5b6dea19b32f/resourceGroups/mms-weu/providers/Microsoft.OperationalInsights/workspaces/mike-demo/savedSearches/$groupID`?api-version=2015-03-20 $groupJson
 
$groupId="My Computer Groups | displayName_ControllerVM"
$groupJson="{'etag': 'W/`"datetime\'2017-03-03T04:20:54.2054Z\'`"', 'properties': { 'Category': 'My Computer Groups', 'DisplayName':'displayName_ControllerVM', 'Query':'Computer IN {XA-Controller} | distinct Computer', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"
armclient put /subscriptions/b81adc9c-f249-4121-805c-5b6dea19b32f/resourceGroups/mms-weu/providers/Microsoft.OperationalInsights/workspaces/mike-demo/savedSearches/$groupID`?api-version=2015-03-20 $groupJson
 
$groupId="My Computer Groups | displayName_JumpBoxVM"
$groupJson="{'etag': 'W/`"datetime\'2017-03-03T04:20:54.2054Z\'`"', 'properties': { 'Category': 'My Computer Groups', 'DisplayName':'displayName_JumpBoxVM', 'Query':'Computer IN {XA-JumpBox} | distinct Computer', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"
armclient put /subscriptions/b81adc9c-f249-4121-805c-5b6dea19b32f/resourceGroups/mms-weu/providers/Microsoft.OperationalInsights/workspaces/mike-demo/savedSearches/$groupID`?api-version=2015-03-20 $groupJson
 
$groupId="My Computer Groups | displayName_JumpBox"
$groupJson="{'etag': 'W/`"datetime\'2017-03-03T04:20:54.2054Z\'`"', 'properties': { 'Category': 'My Computer Groups', 'DisplayName':'displayName_JumpBox', 'Query':'Computer IN {JumpBox} | distinct Computer', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"
armclient put /subscriptions/b81adc9c-f249-4121-805c-5b6dea19b32f/resourceGroups/mms-weu/providers/Microsoft.OperationalInsights/workspaces/mike-demo/savedSearches/$groupID`?api-version=2015-03-20 $groupJson
 
$groupId="My Computer Groups | environment_PREPROD"
$groupJson="{'etag': 'W/`"datetime\'2017-03-03T04:20:54.2054Z\'`"', 'properties': { 'Category': 'My Computer Groups', 'DisplayName':'environment_PREPROD', 'Query':'Computer IN {JumpBox} | distinct Computer', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"
armclient put /subscriptions/b81adc9c-f249-4121-805c-5b6dea19b32f/resourceGroups/mms-weu/providers/Microsoft.OperationalInsights/workspaces/mike-demo/savedSearches/$groupID`?api-version=2015-03-20 $groupJson
 
$groupId="My Computer Groups | displayName_DomainControllerVM"
$groupJson="{'etag': 'W/`"datetime\'2017-03-03T04:20:54.2054Z\'`"', 'properties': { 'Category': 'My Computer Groups', 'DisplayName':'displayName_DomainControllerVM', 'Query':'Computer IN {XA-DC} | distinct Computer', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"
armclient put /subscriptions/b81adc9c-f249-4121-805c-5b6dea19b32f/resourceGroups/mms-weu/providers/Microsoft.OperationalInsights/workspaces/mike-demo/savedSearches/$groupID`?api-version=2015-03-20 $groupJson
 
$groupId="My Computer Groups | owner_miwestaw"
$groupJson="{'etag': 'W/`"datetime\'2017-03-03T04:20:54.2054Z\'`"', 'properties': { 'Category': 'My Computer Groups', 'DisplayName':'owner_miwestaw', 'Query':'Computer IN {JumpBox} | distinct Computer', 'Tags': [{'Name': 'Group', 'Value': 'Computer'}], 'Version':'1'  }"
armclient put /subscriptions/b81adc9c-f249-4121-805c-5b6dea19b32f/resourceGroups/mms-weu/providers/Microsoft.OperationalInsights/workspaces/mike-demo/savedSearches/$groupID`?api-version=2015-03-20 $groupJson
 
