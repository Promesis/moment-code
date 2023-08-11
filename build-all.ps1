function Test-CustomBuildScript 
{
    param (
        $Directory
    );

    return Test-Path $Directory\build-this.ps1;
}

function Test-DotnetProjectFile 
{
    param (
        $Directory
    );
    
    $NowLocation = (Get-Location).Path;
    Set-Location $Directory;
    $Result =  (Test-Path *.csproj) -or (Test-Path *.sln);
    Set-Location $NowLocation;
    return $Result;
}

function Build-Directory {
    param (
        $DirectoryName
    );
    
    $ReturnValue = -1;
    if (Test-DotnetProjectFile $DirectoryName)
    {
        $NowLocation = (Get-Location).Path;
        Set-Location $DirectoryName;
        $ReturnValue = dotnet msbuild --nologo;
        Set-Location $NowLocation;
    }
    else 
    {
        Write-Error -Message "---! Error: Directory `"$DirectoryName`" doesn't contains .NET project file.";
    }
    return $ReturnValue;
}

function Build-CustomDirectory
{
    param (
        $DirectoryName
    );

    $NowLocation = (Get-Location).Path;
    Set-Location $DirectoryName;
    $ReturnValue = ./build-this.ps1;
    Set-Location $NowLocation;
    return $ReturnValue;
}


function Build-Topic 
{
    param (
        $TopicName
    );
    $NowLocation = (Get-Location).Path;
    Set-Location $TopicName;

    $SubDirectories = Get-ChildItem -Attributes "directory" | Select-Object -Property Name;
    $SubDirectoryNames = $SubDirectories.Name;
    $Index = 1;
    foreach ($SubDirectory in $SubDirectoryNames)
    {
        Write-Output "---- Building item $Index / $($SubDirectories.Length) ...";
        Build-Directory $SubDirectory;
        $Index++;
    }
    Set-Location $NowLocation;
}

function Build-Language
{
    param (
        $LanguageName
    );

    $NowLocation = (Get-Location).Path;
    Set-Location $LanguageName;

    $TopicList = Get-ChildItem -Attributes "directory" | Select-Object -Property Name;
    $TopicNameList = $TopicList.Name;
    $Index = 1;
    foreach ($Topic in $TopicNameList)
    {
        Write-Output "---- Building topic $Index / $($TopicList.Length) ...";
        Build-Topic $Topic;
        $Index++;
    }
    Set-Location $NowLocation;
}

function Build-All
{
    $LanguageList = Get-ChildItem -Attributes "directory" | Select-Object -Property Name;
    $LanguageList = $LanguageList.Name;
    Write-Output "---- Building All Targets ...";

    foreach ($Language in $LanguageList)
    {
        Write-Output "---- Building language `"$Language`" ...";
        Build-Language $Language;
    }
}

Build-All;