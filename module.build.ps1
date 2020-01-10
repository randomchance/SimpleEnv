param(
    $PSRepository = (property PSRepository 'LocalRepository'),
    $OutputDirectory = (property build_ArtifactStagingDirectory 'Output')
)

# $script:ModuleName = Get-ChildItem .\*\*.psm1 | Select-Object -ExpandProperty BaseName
# $script:Source = Join-Path $BuildRoot $ModuleName
# $script:SourceManifest = Join-Path $Source "$ModuleName.psd1"
# $script:Output = Join-Path $BuildRoot output
# $script:Version = (Import-PowerShellDataFile -Path "$SourceManifest").ModuleVersion
# $script:Destination = Join-Path $Output "$ModuleName/$Version"
# $script:ModulePath = "$Destination\$ModuleName.psm1"
# $script:ManifestPath = "$Destination\$ModuleName.psd1"
# $script:Imports = ( 'classes', 'private', 'public' )
# $script:ImportInit = 'Pre-Module.ps1'
# $script:ImportFinal = 'Post-Module.ps1'

. .\BuildTasks\InitBuild.ps1

Write-Host 'Import common tasks'
Get-ChildItem -Path $buildroot\BuildTasks\*.Task.ps1 |
ForEach-Object { Write-Host $_.FullName; . $_.FullName }


function BumpVersion
{
    [CmdletBinding()]    
    param(
        [switch]$Major,
        [switch]$Minor,
        [switch]$Build,
        [switch]$Revision
    )

    $Manifest = Get-Item -Path $SourceManifest 
    Write-Verbose "Updating $($Manifest.FullName)" -Verbose
    $Current = Test-ModuleManifest -Path $Manifest.FullName

    [int] $MajorVersion = (0, $Current.Version.Major)[($Current.Version.Major -ge 0)]
    [int] $MinorVersion = (0, $Current.Version.Minor)[($Current.Version.Minor -ge 0)]
    [int] $BuildVersion = (0, $Current.Version.Build)[($Current.Version.Build -ge 0)]
    [int] $RevisionVersion = (0, $Current.Version.Revision)[($Current.Version.Revision -ge 0)]

    if ($Major.IsPresent)
    {
        $MajorVersion ++
    }
    if ($Minor.IsPresent)
    {
        $MinorVersion ++
    }
    if ($Build.IsPresent)
    {
        $BuildVersion ++
    }

    if ($Revision.IsPresent)
    {
        $RevisionVersion ++
    }

    $NewVersion = [version]::new($MajorVersion, $MinorVersion, $BuildVersion, $RevisionVersion)
    #if ($PSCmdlet.ShouldContinue("Are you sure you want to update the module version FROM: [$Version] TO: [$NewVersion] ?"))
    if ( $PSCmdlet.ShouldContinue($NewVersion, "$Version will be updated to:"))
    {
        Write-Verbose "New Module version = $NewVersion" -Verbose
        Update-ModuleManifest -Path $Manifest.FullName -ModuleVersion $NewVersion
    } 
}

# Synopsis: increments Module x.{minor}.x.x version 
Task BumpMinor {
    BumpVersion -Minor
}

# Synopsis: increments Module x.x.{build}.x version 
Task BumpBuild {
    BumpVersion -Build
}

# Synopsis: increments Module x.x.x.{revision} version 
Task BumpRevision {
    BumpVersion -Revision
}

# Synopsis: Build the module.
Task Build  Copy, BuildModule, BuildManifest 

# Execute Tests
Task Test Build, Pester

Task CI Analyze, Build

# Synopsis: publish module to repository supplied by ($PSRepository or ENV:PSRepository)
Task Publish Clean, Build, Test, PublishModule

# Synopsis: Default build and test
Task Default Build, Test

Task Prop {
    Write-Verbose "Property PSRepository [$PSRepository]"
}

Task . Default

