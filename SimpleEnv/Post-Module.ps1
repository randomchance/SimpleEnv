if (Test-Path -Path $Script:Configuration.ConfigFilePath)
{
    Import-SimpleEnv -Filepath $Script:Configuration.ConfigFilePath 
}
