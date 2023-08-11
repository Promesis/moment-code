function Test-ItemBuildingScript
{
    param (
        $item_dir
    );
    $root = (Get-Location).Path;
    Set-Location $item_dir;
    $result = Test-Path -Path "build-item.ps1";
    Set-Location $root;

    return $result;
}

function Test-ProjectFileOrSolutionFile
{
    param (
        $item_dir
    );
    $root = (Get-Location).Path;
    Set-Location $item_dir;
    $result = (Test-Path -Path "*.csproj") -or (Test-Path -Path "*.sln");
    Set-Location $root;

    return $result;
}


$subdirectory_objects = Get-ChildItem -Attributes "directory" | Select-Object -Property "Name"
$subdirectories = $subdirectory_objects.Name;
$count = 1;
foreach ($item in $subdirectories)
{
    Write-Output "---- Building item `"$item`" ($count / $($subdirectory_objects.Length)) ...";
    $root = (Get-Location).Path;
    if (Test-ItemBuildingScript $item)
    {
        Set-Location $item;
        .\build-item.ps1;
        Set-Location $root;
    }
    elseif (Test-ProjectFileOrSolutionFile $item)
    {
        Set-Location $item;
        dotnet msbuild --nologo;
        Set-Location $root;
    }
    else 
    {
        Write-Error -Message "Error: item `"$item`" contains neither project / solution file nor custom building script. Skipping...";
    }

    $count++;
}

