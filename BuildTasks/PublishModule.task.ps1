Task PublishModule {
    $publishParam = @{
        Path       = $Destination
        Repository = $PSRepository
        Force      = $true
    }

    if ( $Null -eq (Get-PSRepository -Name $PSRepository ))
    {
        throw "PSRepository [$PSRepository] is not configured"
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

