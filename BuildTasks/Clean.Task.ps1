# Synopsis: Remove output files.
Task Clean {
    remove $Output
    New-Item  -Type Directory -Force -Path $Destination | Out-Null
}
