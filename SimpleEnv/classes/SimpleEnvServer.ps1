
class SimpleEnvServer
{
    [string] $Name
    [string] $ComputerName
    [string] $Environment
    [string[]] $Roles = @()
    [string[]] $Tags = @()
    [hashtable] $Properties = @{ }
}
