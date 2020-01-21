
class SimpleEnvServer
{
    [string] $Name
    [string] $ComputerName
    [string] $Environment
    [string[]] $Roles = @()
    [string[]] $Tags = @()
    [hashtable] $Properties = @{ }
    
    [void] AddTag([string]$Tag)
    {
        $this.Tags = $this.Tags + $Tag | Sort-Object -Unique
    }
    [void] RemoveTag([string]$Tag)
    {
        $this.Tags = $this.Tags | Where-Object { $_ -notlike $Tag }
    }

    [void] AddRole([string]$Role)
    {
        $this.Roles = $this.Roles + $Role | Sort-Object -Unique
    }
    [void] RemoveRole([string]$Role)
    {
        $this.Roles = $this.Roles | Where-Object { $_ -notlike $Role }
    }
    
}
