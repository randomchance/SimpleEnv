
function Export-SimpleEnv
{
    <#
    .description 
    
    Writes the current SimpleEnv to a JSON file (with utf8 encoding).

    .parameter FilePath 
    The Filepath to write too.

    .PARAMETER Force

    Overwrites existing file without confirmation

    .example 
    PS> Export-SimpleEnv -FilePath '~\desktop\MyEnvironment.SimpleEnv.json'

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
        $Force
    )

    $FileParams = @{
        FilePath = $FilePath 
        Encoding = 'utf8'
    }

    if ($Force.IsPresent)
    {
        $FileParams['Force'] = $true
    }
    else
    {
        $FileParams['NoClobber'] = $true
    }

    $script:Environment | ConvertTo-Json -Depth 5 | Out-File @FileParams
}
