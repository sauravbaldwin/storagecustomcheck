#Connect-AzAccount
$storageobj = @()
$Subscriptions = Get-AzSubscription
foreach ($sub in $Subscriptions)
{
    Set-AzContext -Subscription $sub
$storages = Get-AzStorageAccount 
foreach ($storage in $storages)
    {
        $usedCapacity = (Get-AzMetric -ResourceId $storage.Id -MetricName "UsedCapacity").Data
        $usedCapacityInMB = $usedCapacity.Average / 1024 / 1024
        $usedCapacityInGB=$usedCapacity.Average / 1024 / 1024 / 1024
                $storageInfo = [pscustomobject]@{
                    'Resource ID'=$storage.Id
                    'Storage Account Name'=$storage.StorageAccountName
                    'Usage (In MB)' = $usedCapacityInMB
                    'Usage (In GB)' = $usedCapacityInGB
                    'ResourceGroupName' = $storage.ResourceGroupName
                    'Subscription Name'=$sub.Name
                    'Access Tier'=$storage.AccessTier
                    'Kind(V1/V2)'=$storage.Kind
                    'Location'=$storage.Location
                    'Replication'=$storage.Sku.Name
                    'Secure Transfer Enabled'=$storage.EnableHttpsTrafficOnly
                    
                 }
            $storageobj += $storageInfo
    }
}
$storageobj | Export-Csv -Path "xxxx\xxxx\xxxx\\Documents\xxxx\xxxxxx.csv" -NoTypeInformation
Write-Host "Storage Account usage data list written to the csv file"
Invoke-Item "xxxx\xxxx\xxxx\\Documents\xxxx\xxxxxx.csv"