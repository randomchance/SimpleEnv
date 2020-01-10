$local:indent = ' '
  
Write-Verbose "Initializing build variables" -Verbose

Write-Verbose "$Indent Existing BuildRoot [$BuildRoot]" -Verbose
Write-Verbose "$Indent Module repository [$PSRepository ]" -Verbose

if ($PSRepository -like 'temp_build')
{
    Write-Verbose "Module will be published to a temporary repository..." -Verbose
    $Script:UseTempBuildRepo = $true
}
else
{
    $Script:UseTempBuildRepo = $false
}

$script:ModuleName = Get-ChildItem .\*\*.psm1 | Select-Object -ExpandProperty BaseName
Write-Verbose "$Indent Module Name [$ModuleName]" -Verbose

$script:Source = Join-Path $BuildRoot $ModuleName
Write-Verbose "$Indent Module source [$Source]" -Verbose

$script:SourceManifest = Join-Path $Source "$ModuleName.psd1"
Write-Verbose "$Indent Module source manifest [$SourceManifest]" -Verbose

$script:Version = (Import-PowerShellDataFile -Path "$SourceManifest").ModuleVersion
Write-Verbose "$Indent Module Version [$Version]" -Verbose

$script:Output = If (-not (Test-Path $OutputDirectory)) 
{
    Join-Path $BuildRoot 'output' 
} 
else
{
    $OutputDirectory
}

Write-Verbose "$Indent Build output root [$Output]" -Verbose

$script:Destination = Join-Path $Output "$ModuleName/$Version"
Write-Verbose "$Indent Build output directory [$Destination]" -Verbose

if ($PSRepository -like 'temp_build')
{
    $Script:BuildRepoRoot = Join-Path $Output $NugetArtifactPath
    Write-Verbose "$Indent Temporary PSRepository directory [$BuildRepoRoot]" -Verbose
}


$script:ModulePath = "$Destination\$ModuleName.psm1"
$script:ManifestPath = "$Destination\$ModuleName.psd1"


$script:Imports = ( 'classes', 'private', 'public' )
Write-Verbose "$Indent Imported folders [$($Imports -join ', ')]" -Verbose


$script:ImportInit = 'Pre-Module.ps1'
Write-Verbose "$Indent Imported module init script [$ImportInit]" -Verbose

$script:ImportFinal = 'Post-Module.ps1'
Write-Verbose "$Indent Imported module finialization script [$ImportFinal]" -Verbose

$Script:TestFile = "$Output\TestResults_PS_.xml"
Write-Verbose "  TestFile [$TestFile]" -Verbose

