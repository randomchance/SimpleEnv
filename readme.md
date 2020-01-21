# SimpleEnvironment

Get-Server and other tools for working with a simple environment configuration, backed by a single JSON File.

Also a very rough example of using Format files!

The default environment file is `$Env:USERPROFILE/SimpleENV.json`, but you can set it in your profile with `Set-SimpleEnvConfiguration`.

## Get-SimpleEnvServer

### SYNTAX

`Get-SimpleEnvServer [-JustComputerName] [-All] [<CommonParameters>]`

`Get-SimpleEnvServer [[-Name] <String>] [-Role <String>] [-Tag <String>] [-Environment <String>] [-JustComputerName] [<CommonParameters>]`

### DESCRIPTION

Retrieves the specified servers from the loaded SimpleEnv.

### PARAMETERS

| parameter        | type            | description                                                                   |
|------------------|-----------------|-------------------------------------------------------------------------------|
| Name             | String          | Selects servers with a matching name, wildcard patterns are supported.        |
| Role             | String          | Select Servers that have a Role that matches the wildcard pattern.            |
| Tag              | String          | Select Servers that have a tag that matches the wildcard pattern.             |
| Environment      | String          | Selects servers with a matching Environment, wildcard patterns are supported. |
| JustComputerName | SwitchParameter | Return only the ComputerName(s) of the selected servers.                      |
| All              | SwitchParameter | Return all servers.                                                           |

### Examples

```PowerShell

PS>Get-SimpleEnvServer

Name            ComputerName                        Tags                                  Properties                                     
----            --------                        ----                                  ----------                                     
DevOps          DevOps.test.env.com            {dev, 2019, infrastructure, ops}       {DistinguishedName}    
Dev-box         Dev-box.test.env.com           {dev, 2012r2,  developer}       {DistinguishedName}

```

```PowerShell

PS>Get-Server -Name *ops

Name            ComputerName                        Tags                                  Properties                                     
----            --------                        ----                                  ----------                                     
DevOps          DevOps.test.env.com            {dev, 2019, infrastructure, ops}       {DistinguishedName}

```
```PowerShell

PS>Get-Server -Tag 2012*

Name            ComputerName                        Tags                                  Properties                                     
----            --------                        ----                                  ----------                                     
Dev-box         Dev-box.test.env.com           {dev, 2012r2,  developer}       {DistinguishedName}
```

```PowerShell

PS>Get-Server -Tag 2012* -JustComputerName

Dev-box.test.env.com
```

