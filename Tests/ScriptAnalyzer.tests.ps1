#$Script:ModuleRoot = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent
#$Script:ModuleName =  = Get-ChildItem "$ModuleRoot\*\*.psm1" | Select-Object -ExpandProperty BaseName

#$Script:SourceRoot = Join-Path -Path $ModuleRoot -ChildPath $ModuleName




Describe "All commands pass PSScriptAnalyzer rules" -Tag 'Build' {
    $rules = "$BuildRoot\ScriptAnalyzerSettings.psd1"
    $scripts = Get-ChildItem -Path $Destination -Include '*.ps1', '*.psd1', '*.psm1' -Recurse |
    Where-Object FullName -notmatch 'Classes'

    foreach ($script in $scripts)
    {
        Context $script.FullName {
            $results = Invoke-ScriptAnalyzer -Path $script.FullName -Settings $rules
            if ($results)
            {
                foreach ($rule in $results)
                {
                    It $rule.RuleName {
                        $message = "{0} Line {1}: {2}" -f $rule.Severity, $rule.Line, $rule.Message
                        $message | Should Be ""
                    }
                }
            }
            else
            {
                It "Should not fail any rules" {
                    $results | Should BeNullOrEmpty
                }
            }
        }
    }
}


# Describe "PSScriptAnalyzer rule-sets" -Tag Build {

#     $Rules = Get-ScriptAnalyzerRule 
#     $scripts = Get-ChildItem $moduleRoot -Include *.ps1, *.psm1, *.psd1 -Recurse | Where-Object fullname -notmatch 'classes'

#     foreach ( $Script in $scripts )
#     {
#         Context "Script '$($script.FullName)'" {
#             $results = Invoke-ScriptAnalyzer -Path $script.FullName -includeRule $Rules
#             if ($results)
#             {
#                 foreach ($rule in $results)
#                 {
#                     It $rule.RuleName {
#                         $message = "{0} Line {1}: {2}" -f $rule.Severity, $rule.Line, $rule.message
#                         $message | Should Be ""
#                     }

#                 }
#             }
#             else
#             {
#                 It "Should not fail any rules" {
#                     $results | Should BeNullOrEmpty
#                 }
#             }
#         }
#     }
# }