# Create 10 files with .sol extension
for ($i = 1; $i -le 24; $i++) {
    $fileName = ".\Chapter4\SourceCode4_$i.sol"
    New-Item -Path $fileName -ItemType File
    Write-Host "Created file: $fileName"
}