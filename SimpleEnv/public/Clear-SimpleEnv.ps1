function Clear-SimpleEnv
{
    <# 
.Description 
Resets the in-memory SimpleEnv to a blank environment.

.example 
PS> Clear-SimpleEnv

#>
    [CmdletBinding()]
    param ()
    Write-Verbose "Setting environment to default."
    ClearEnvironment
}