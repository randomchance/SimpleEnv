function Get-SimpleEnvServer
{
    <#
    .description 
    Retrieves the specified servers from the loaded SimpleEnv.

    .parameter Name 
    Selects servers with a matching name, wildcard patterns are supported.

    .parameter Tag 
    Select Servers that have a tag that matches the wildcard pattern.

   .parameter Environment 
    Selects servers with a matching Environment, wildcard patterns are supported.

    .parameter All 
    Return all servers.

    .parameter JustComputerName 
    Return only the ComputerName(s) of the selected servers.

    .example 
    PS> Get-SimpleEnvServer

    Name            ComputerName                        Tags                                  Properties                                     
    ----            --------                        ----                                  ----------                                     
    DevOps          DevOps.test.env.com            {dev, 2019, infrastructure, ops}       {DistinguishedName}    
    Dev-box         Dev-box.test.env.com           {dev, 2012r2,  developer}       {DistinguishedName}     

    .example
    PS> Get-Server -Name *ops

    Name            ComputerName                        Tags                                  Properties                                     
    ----            --------                        ----                                  ----------                                     
    DevOps          DevOps.test.env.com            {dev, 2019, infrastructure, ops}       {DistinguishedName}    
    

    .example 
    PS> Get-Server -Tag 2012*

    Name            ComputerName                        Tags                                  Properties                                     
    ----            --------                        ----                                  ----------                                     
    Dev-box         Dev-box.test.env.com           {dev, 2012r2,  developer}       {DistinguishedName}     


    .example 
    PS> Get-Server -Tag 2012* -JustComputerName

    Dev-box.test.env.com



    #>
    [CmdletBinding(DefaultParameterSetName = 'all')]
    param (
        # 
        [Parameter(Mandatory = $false, ParameterSetName = 'filtered', Position = 0)]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [string]
        $Name,

        # 
        [Parameter(Mandatory = $false, ParameterSetName = 'filtered')]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [string]
        $Role,

        # 
        [Parameter(Mandatory = $false, ParameterSetName = 'filtered')]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [string]
        $Tag,

        # 
        [Parameter(Mandatory = $false, ParameterSetName = 'filtered')]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [string]
        $Environment,

        # Parameter help description
        [Parameter(Mandatory = $false, ParameterSetName = 'all')]
        [Parameter(Mandatory = $false, ParameterSetName = 'filtered')]
        [Alias('DnsName')]
        [switch]
        $JustComputerName,

        # Parameter help description
        [Parameter(Mandatory = $false, ParameterSetName = 'all')]
        [switch]
        $All

    )
    
    begin
    {
        if ($script:Environment.Servers.count -eq 0)
        {
            Write-Warning -Message ("No servers in environment [{0}] Try importing another configuration, or adding a server." -f $Script:Configuration.ConfigFilePath)
        }

        [bool] $SkipName = (-not $PSBoundParameters.ContainsKey('Name'))
        [bool] $SkipTags = (-not $PSBoundParameters.ContainsKey('tag'))
        [bool] $SkipRoles = (-not $PSBoundParameters.ContainsKey('role'))
        [bool] $SkipEnv = (-not $PSBoundParameters.ContainsKey('Environment'))
     
        filter OutputFormat
        {
            
            if ($JustComputerName.IsPresent)
            {
                $Psitem.ComputerName
            }
            else
            {
                $Psitem
            }
        }
    }
    
    Process
    {
        $Servers = if ($PSCmdlet.ParameterSetName -like 'all')
        {
            $script:Environment.Servers
        }
        else
        {
            $script:Environment.Servers | 
            Where-Object { ($SkipName -or ($_.Name -like $Name )) } | 
            Where-Object { ($SkipTags -or ($_.Tags -like $Tag )) } | 
            Where-Object { ($SkipRoles -or ($_.Roles -like $Role )) } | 
            Where-Object { ($SkipEnv -or ($_.Environment -like $Environment )) }  
        }
        Write-Verbose "Found $($Servers.count) servers."
        $Servers | OutputFormat

    }    
    end
    {
    }
}


Set-Alias -Name 'Get-Server' -Value Get-SimpleEnvServer 