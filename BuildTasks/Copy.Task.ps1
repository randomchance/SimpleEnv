
# Synopsis: Copy files to output directory
Task Copy {

    Write-Output "  Create Directory [$Destination]"
    $null = New-Item -Type Directory -Path $Destination -Force -ErrorAction Ignore

    Get-ChildItem $source -File | 
    Where-Object name -NotMatch "$ModuleName\.ps[dm]1" | 
    Where-Object Name -NotIn ($ImportInit, $ImportFinal) |
    Copy-Item -Destination $Destination -Force -PassThru | 
    ForEach-Object { "  Create [.{0}]" -f $_.fullname.replace($PSScriptRoot, '') }

    Get-ChildItem $source -Directory | 
    Where-Object name -NotIn $imports | 
    Copy-Item -Destination $Destination -Recurse -Force -PassThru | 
    ForEach-Object { "  Create [.{0}]" -f $_.fullname.replace($PSScriptRoot, '') }
}
