
function Get-SimpleEnvConfiguration
{
    <#
.description 

Returns the current SimpleEnv configuration as a hashtable.

.PARAMETER All

Returns the full configuration

.PARAMETER FilePath

Returns only the FilePath of the backing JSON file.


.example 

PS>  Get-SimpleEnvConfiguration


#>
    [CmdletBinding(DefaultParameterSetName = 'all')]
    
    [OutPutType([hashtable], ParameterSetName = 'all')]
    [OutPutType([string], ParameterSetName = 'filepath')]

    param (


        [Parameter(ParameterSetName = 'all')]
        [switch]
        $All,


        [Parameter(ParameterSetName = 'filepath')]
        [switch]
        $FilePath

    )
    
    if ($PSCmdlet.ParameterSetName -eq 'all')
    {
        return $Script:Configuration 
    }
    else
    {
        if ($FilePath.IsPresent)
        {
            $Script:Configuration.ConfigFilePath
        }
    }    
}
