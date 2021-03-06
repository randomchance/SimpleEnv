#$Script:ModuleRoot = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent
#$Script:ModuleName = $Script:ModuleName = Get-ChildItem $ModuleRoot\*\*.psm1 | Select-object -ExpandProperty BaseName

Describe "Public commands have comment-based or external help" -Tags 'Build' {
    try
    {
        Remove-Module -Name $ModuleName -Force
    }
    catch
    {

    }
    $ImportFrom = Resolve-Path "$Output/$ModuleName"
    Import-Module $ImportFrom -Force -RequiredVersion $Version
    $functions = Get-Command -Module $ModuleName
    $help = foreach ($function in $functions)
    {
        Get-Help -Name $function.Name
    }

    foreach ($node in $help)
    {
        Context $node.Name {
            It "Should have a Description or Synopsis" {
                ($node.Description + $node.Synopsis) | Should Not BeNullOrEmpty
            }

            It "Should have an Example" {
                $node.Examples | Should Not BeNullOrEmpty
            }

            It "Should have an Example that matches it's name" {
                $node.Examples | Out-String | Should -Match ($node.Name)
            }

            foreach ($parameter in $node.Parameters.Parameter)
            {
                if ($parameter -notmatch 'WhatIf|Confirm')
                {
                    It "Should have a Description for Parameter [$($parameter.Name)]" {
                        $parameter.Description.Text | Should Not BeNullOrEmpty
                    }
                }
            }
        }
    }
    
    try
    {
        Remove-Module $ImportFrom
    }
    catch
    {
        
    }
}