



function Build-All
{
    param ();

    $language_dir_objects = Get-LanguageDirObjects;
    $language_dirs = $language_dir_objects.Name;

    $built_language_dirs_count = 0;
    foreach ($language_dir in $language_dirs)
    {
        $built_language_dirs_count++;
        Build-LanguageDir $language_dir $built_language_dirs_count $language_dir_objects.Length;

    }
}

function Get-LanguageDirObjects
{
    return (Get-ChildItem -Attributes "directory" | Select-Object -Property "Name");
}

function Build-LanguageDir
{
    param (
        $language_dir,
        $built_language_dirs,
        $total_language_dirs
    );

    Write-Output "---- Building language `"$language_dir`" ($built_language_dirs / $total_language_dirs)";

    $root = (Get-Location).Path;
    if (Test-LanguageBuildingScript $language_dir)
    {
        Set-Location $language_dir;
        ./build.ps1;
        Set-Location $root;
    }
    else 
    {
        Write-Error -Message "Directory `"$language_dir`" doesn't contain build script";
    }

    Set-Location $root;
}


function Test-LanguageBuildingScript
{
    param (
        $language_dir
    );
    $root = (Get-Location).Path;
    Set-Location $language_dir;
    $result = Test-Path -Path "build.ps1";
    Set-Location $root;

    return $result;
}
Build-All;
