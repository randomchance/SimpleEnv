function Set-SimpleEnvConfiguration
{
    <#
.SYNOPSIS 

Set SimpleEnv Configuration options.

.PARAMETER FilePath 

Sets the path of the backing JSON File, and attempts to import it if it exists.
If you want to overwrite the file without importing it, try Export-SimpleEnv instead.

.EXAMPLE 

PS> Set-SimpleEnvConfiguration -FilePath 'myEnv.SimpleEnv.JSON'
Imports the environment from myEnv.SimpleEnv.JSON, and will persist changes back to it.



.LINK
Export-SimpleEnv

#>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'low')]
    param (
        # 
        [Parameter(Mandatory = $true)]
        [string]
        $FilePath
    )
    
    if ($PSCmdlet.ShouldProcess($Filepath, "Set the source environment JSON file to:" ))
    {
        try
        {
            Write-Verbose "Importing Configuration from $Filepath"
            if (Test-Path $Filepath)
            {
                Import-SimpleEnv -Filepath $Filepath
            }
            $Script:Configuration.ConfigFilePath = $Filepath
            
        }
        catch
        {
            Write-Error "Unable to import $Filepath"
        }    
    }

    
}
