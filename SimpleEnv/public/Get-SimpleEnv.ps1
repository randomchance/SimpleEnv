function Get-SimpleEnv
{
    <#
.Synopsis
Get the entire stored simpleEnv as an object.

.Parameter Full

Get the entire stored simpleEnv as an object.


.EXAMPLE

PS> Get-SimpleEnv

Get the entire stored simpleEnv as an object.

.EXAMPLE

PS> Get-SimpleEnv -Server

Get the list of all server


#>


    [CmdletBinding(DefaultParameterSetName = 'Full')]
    param (
        #
        [Parameter(Mandatory = $true, ParameterSetName = 'Full')]
        [switch]
        $Full,

        [Parameter(Mandatory = $true, ParameterSetName = 'servers')]
        [switch]
        $Servers#,

        # [Parameter(Mandatory = $false, ParameterSetName = 'info')]
        # [switch]
        # $EnvironmentInfo
    )

    begin
    {

    }

    process
    {
        if ($PSCmdlet.ParameterSetName -eq 'Full')
        {
            $script:Environment

        }
        elseif ($PSCmdlet.ParameterSetName -eq 'servers')
        {
            $script:Environment.Servers

        }
        elseif ($PSCmdlet.ParameterSetName -eq 'info')
        {
            $script:Environment.EnvironmentInfo
        }
    }

    end
    {
    }
}
