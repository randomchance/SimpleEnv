
function Save-SimpleEnv
{
    <#
    
.Description 
Exports the current SimpleEnv configuration to the current Configuration File Path

.Example 
PS>  Save-SimpleEnv
#>

    [CmdletBinding()]

    $ExportArgs = @{
        FilePath = $Script:Configuration.ConfigFilePath
        Verbose  = $VerbosePreference
        Force    = $true
    }
    Export-SimpleEnv @ExportArgs
}
