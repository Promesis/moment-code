function Test-TopicBuildingScript
{
    param (
        $topic_dir
    );
    $root = (Get-Location).Path;
    Set-Location $topic_dir;
    $result = Test-Path -Path "build-topic.ps1";
    Set-Location $root;

    return $result;
}


$subdirectory_objects = Get-ChildItem -Attributes "directory" | Select-Object -Property "Name"
$subdirectories = $subdirectory_objects.Name;
$count = 1;
foreach ($topic in $subdirectories)
{
    Write-Output "---- Building topic `"$item`" ($count / $($subdirectory_objects.Length)) ...";
    $root = (Get-Location).Path;
    if (Test-TopicBuildingScript $topic)
    {
        Set-Location $topic;
        .\build-topic.ps1;
        Set-Location $root;
    }
    else 
    {
        Write-Error -Message "Error: topic `"$topic`" doesn't contain building script. Skipping...";
    }

    $count++;
}

