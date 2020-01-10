
function Add-SimpleEnvServer
{
    <#
    .SYNOPSIS 
    Adds a SimpleEnvServer object to the loaded environment, and optionally save the changes back to the environment config.

    .PARAMETER ServerObject 
    The [SimpleEnvServer] object to add.

    .PARAMETER Save 
    Save changes back to the environment config file at the end of pipeline exectution.

    .EXAMPLE 
    PS> (1..4) | %{New-SimpleEnvServer -Name "TestServer_$_"} | Add-SimpleEnvServer -Save
        Creates new SimpleEnv Servers named: Test_1,Test_2,Test_3,Test_4 and adds them to the loaded environment, 
        then saves the changes back to the backing JSON file.
    
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'low')]    
    param (
        
        # SimpleEnvServer object
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [object]
        $ServerObject,

        
        # 
        [Parameter(Mandatory = $false)]
        [switch]
        $Save
    )
    

    process
    {
        $server = [SimpleEnvServer]$ServerObject
        if ($PSCmdlet.ShouldProcess($server.Name, "Add to the existing environment?"))
        {
            $script:Environment.Servers += $server
            
        }
    }
    end
    {
        
        if ($Save.IsPresent -and $PSCmdlet.ShouldProcess( "Save changes to the existing environment?") )
        {
            $SaveArgs = @{
                Verbose = $Verbose
            }
            
            Save-SimpleEnv @SaveArgs
        }
    }

}


