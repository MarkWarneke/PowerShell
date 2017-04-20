function GetFiles($path = $pwd, [string[]]$exclude) 
{ 
    foreach ($item in Get-ChildItem $path)
    {

        if (Test-Path $item.FullName -PathType Container) 
        {
            $item 
            GetFiles $item.FullName $exclude
        } 
        else 
        { 
            $item 
        }
    } 
}