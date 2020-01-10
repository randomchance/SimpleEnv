Task Analyze {
    $params = @{
        IncludeDefaultRules = $true
        Path                = $Source
        Settings            = "$BuildRoot\ScriptAnalyzerSettings.psd1"
        Severity            = 'Warning'
        ExcludeRule         = @('PSUseToExportFieldsInManifest')
    }

    "Analyzing $Source..."
    $results = Invoke-ScriptAnalyzer @params
    if ($results)
    {
        'One or more PSScriptAnalyzer errors/warnings were found.'
        'Please investigate or add the required SuppressMessage attribute.'
        $results | Format-Table -AutoSize
    }
}