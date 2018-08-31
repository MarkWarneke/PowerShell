$application = New-Object -ComObject word.application

$application.Visible = $false
$document = $application.documents.open("C:\Users\mawarnek\OneDrive - Microsoft\Products\ESAE\ESAEv3_Build_Implementation_Guide-Appendices.docx")
$binding = "System.Reflection.BindingFlags" -as [type]
$properties = $document.BuiltInDocumentPropertiese

foreach ($property in $properties) {
    $pn = [System.__ComObject].invokemember("name", $binding::GetProperty, $null, $property, $null)
    trap [system.exception] {
        write-host -foreground blue "Value not found for $pn"
        continue
    }
    "$pn`: " +
    [System.__ComObject].invokemember("value", $binding::GetProperty, $null, $property, $null)

}
$application.quit()