
function Remove-SimpleEnvServer
{
    <#
.synopsis 

Remove a SimpleEnvServer object from the loaded environment, and optionally save the changes back to the environment config.

.parameter ServerObject 

The [SimpleEnvServer] Object to remove.

.parameter Save 

Save changes back to the environment config file at the end of pipeline exectution.

.example 
PS>  Get-Server -Tag Agent | Remove-SimpleEnvServer -Save
Removes all servers tagged 'Agent' and saves the changes.

#>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'low')]   
    param (
        # 
        # inputobject
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        #        [ValidateScript( { $_ -is [SimpleEnvServer] })]
        [object]
        $ServerObject,

        # 
        [Parameter(Mandatory = $false)]
        [switch]
        $Save
    )
    

    process
    {
        $Server = [SimpleEnvServer]$ServerObject
        if ($PSCmdlet.ShouldProcess($Server.Name, "Remove from existing SimpleEnv ?"))
        {
            $script:Environment.Servers = $script:Environment.Servers | Where-Object { $_ -ne $Server } 
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

