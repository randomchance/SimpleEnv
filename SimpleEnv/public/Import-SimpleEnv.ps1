

function Import-SimpleEnv
{
    <#
.SYNOPSIS 

Imports the specified Json file into the currently loaded SimpleEnv, however changes are still persisted back to the oridginal file.

.PARAMETER FilePath 

Path to the SimpleENV json file to import.

.PARAMETER ClearExisting 

Remove existing servers before importing, instead of combining the environments.

.EXAMPLE 
PS> Import-SimpleEnv -FilePath Test.simpleenv.json -ClearExisting
Should only have the servers in 'Test.simpleenv.json' loaded.

#>

    [CmdletBinding()]
    param (
        # Path to Json file
        [Parameter(Mandatory = $true,
            ParameterSetName = "json",
            ValueFromPipelineByPropertyName = $true
        )]
        [alias("path")]
        [string]
        $FilePath,

        # 
        [Parameter()]
        [switch]
        $ClearExisting
    )
    
    begin
    {
        #$ImportProperties = [SimpleEnvServer].DeclaredProperties.Name

        if ($ClearExisting.IsPresent)
        {
            $script:Environment.Servers.Clear()
        
        }
        function ObjToShallowhashtable($object)
        {

            if ($null -ne $object)
            {
                $props = $object
                $PropTable = @{ }
                $Keys = $props | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name
                $Keys | ForEach-Object {
                    $PropTable.$_ = $props.$_
                }                
                $PropTable
            }
            else
            {
                return @{ }
            }
        }
    }
    
    process
    {
        $temp = Get-Content -Path $Filepath -Raw | ConvertFrom-Json
        # Reset-SimpleEnv 

        $temp.Servers | ForEach-Object {
            $Srv = $_
            if ($null -ne $Srv.Properties)
            {
                $srv.Properties = ObjToShallowhashtable -object $Srv.Properties
            }
        }

        $Temp.Servers | New-SimpleEnvServer | Add-SimpleEnvServer

        if ($null -ne $temp.EnvironmentInfo)
        {
            $script:Environment.EnvironmentInfo = ObjToShallowhashtable -object $Temp.EnvironmentInfo
        }
        elseif ($null -ne $temp.MetaData)
        {
            $script:Environment.EnvironmentInfo = ObjToShallowhashtable -object $Temp.Metadata
        }
    }
    
    end
    {
    }
}