

function New-SimpleEnvServer
{
    <#
.SYNOPSIS 

Creates a new SimpleEnvServer object.

.PARAMETER Name

Friendly name for the server

.PARAMETER ComputerName

The Network addressable name for the computer.
This was changed from DnsName to provide better interoperability with built-in commands.

.PARAMETER Environment

A short environment identifier.


.PARAMETER Tags

A list of strings to tag the server with.

.PARAMETER Roles

A list of strings identifing the servers roles.

.PARAMETER Properties

A hashtable of properties / metadata to store about the server.
This hashtable should be no more than 2 layers deep, or it may not be fully serialized.



.Example

PS>  New-SimpleEnvServer -Name "Test01" 

Server DNS Name Environment Roles Tags Properties
------ -------- ----------- ----- ---- ----------
Test01                      {}    {}   {}



#>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'low')]
    [OutputType([SimpleEnvServer])]
    param (
        
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]
        $Name,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [string]
        $Environment,
        
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('FullName')]
        [Alias('DnsName')]
        [string]
        $ComputerName,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $Tags,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $Roles,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('Metadata')]
        [hashtable]
        $Properties
    )
    
    begin
    {
        $ParametersToImport = [SimpleEnvServer].DeclaredProperties.Name
    }
    
    process
    {
        $Item = @{
            Name = $Name
        }

        $ParametersToImport | ForEach-Object {
            if ($PSBoundParameters.ContainsKey($_))
            {
                $Item[$_] = $PSBoundParameters[$_]
            }
        }
        if ($PSCmdlet.ShouldProcess("Create new SimpleEnvServer object"))
        {
            [SimpleEnvServer]$item
        }   

    }
    
    end
    {
        
    }
}