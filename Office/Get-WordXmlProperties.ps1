Add-Type -AssemblyName System.IO.Compression.FileSystem

$filename = "C:\Users\mawarnek\OneDrive - Microsoft\Products\ESAE\ESAEv3_Build_Implementation_Guide-Appendices.docx"

$zip = [System.IO.Compression.ZipFile]::Open($filename, 'Read')
$propsentry = $zip.GetEntry('docProps/app.xml')
If ($propsentry -ne $null) {
    $stream = $propsentry.Open()
    $reader = New-Object System.IO.StreamReader $stream
    $content = $reader.ReadToEnd()
    $xmldoc = [xml]$content
    $xmldoc.Properties
}
$zip.Dispose()