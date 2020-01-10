
# Synopsis: Build the module manifest
Task BuildManifest {
    
    Write-Output "  Update [$ManifestPath]"
    Copy-Item "$source\$ModuleName.psd1" -Destination $ManifestPath
 
    $functions = Get-ChildItem "$ModuleName\Public\*.ps1" | Where-Object { $_.name -notmatch 'Tests' } | Select-Object -ExpandProperty basename
    #Set-ModuleFunctions -Name $ManifestPath -FunctionsToExport $functions

    Update-ModuleManifest -Path $ManifestPath -FunctionsToExport $functions
} 


Task PublishModule {
    $publishParam = @{
        Path       = $Destination
        Repository = $PSRepository
        Force      = $true
    }

    $Existing = Find-Module $ModuleName -Repository $PSRepository
    
    if ($null -ne $Existing)
    {
        if ($Existing.Version -eq $Version)
        {
            throw "$ModuleName Version $Version already published, did you mean to increment it?"
        }
    }

    Publish-Module @publishParam 

    
}
