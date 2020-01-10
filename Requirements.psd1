@{
    PSDependOptions  = @{
        AddToPath  = $True            # I want to prepend project to $ENV:Path and $ENV:PSModulePath
        Parameters = @{
            Repository = $null # Null allows using all PSRepositories
        }
    }

    # Grab some modules
    InvokeBuild      = 'latest'
    Pester           = 'latest'
    PSScriptAnalyzer = 'latest'
    

    # Clone a git repo
    #'ramblingcookiemonster/PowerShell' = 'master'

    # Download a file
    # 'psrabbitmq.dll' = @{
    #     DependencyType = 'FileDownload'
    #     Source = 'https://github.com/RamblingCookieMonster/PSRabbitMq/raw/master/PSRabbitMq/lib/RabbitMQ.Client.dll'
    # }
}