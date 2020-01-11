

$Script:Configuration = @{
    ConfigFilePath = "$Env:USERPROFILE/SimpleENV.json"
}


function ClearEnvironment
{
    $script:Environment = @{
        SimpleEnvVersion = ''
        EnvironmentInfo  = @{ }
        Servers          = @()
    }

    $Environment.SimpleEnvVersion = [string]$MyInvocation.MyCommand.Module.Version
}

ClearEnvironment
