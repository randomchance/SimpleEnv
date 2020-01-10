

# Synopsis:  Build the module file from imports
Task BuildModule {

    [System.Text.StringBuilder]$stringbuilder = [System.Text.StringBuilder]::new()
    $fileList = @()

    if (Test-Path "$Source\$ImportInit")
    {
        $fileList += Get-Item -Path "$Source\$ImportInit"
    }

    foreach ($folder in $imports )
    {
        [void]$stringbuilder.AppendLine( "Write-Verbose 'Importing from [$Source\$folder]'" )
        if (Test-Path "$source\$folder")
        {
            $fileList += Get-ChildItem "$source\$folder\*.ps1" | Where-Object Name -NotLike '*.Tests.ps1'
        }
    }

    if (Test-Path "$Source\$ImportFinal")
    {
        $fileList += Get-Item -Path "$Source\$ImportFinal"
    }

    foreach ($file in $fileList)
    {
        $shortName = $file.fullname.replace($Source, '')
        Write-Output "  Importing [.$shortName]"
        [void]$stringbuilder.AppendLine( "# .$shortName" ) 
        [void]$stringbuilder.AppendLine( [System.IO.File]::ReadAllText($file.fullname) )
    }

    Write-Output "  Creating module [$ModulePath]"
    Set-Content -Path  $ModulePath -Value $stringbuilder.ToString() 
}