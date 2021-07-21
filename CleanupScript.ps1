try{
    $paths = @("C:\Test\TestFolder\", "C:\Test\TestFolder - mixed\", "C:\Test\TestFolder - older than 7 days\")
    $limit = (Get-Date).AddDays(-7) #files older than 7days

    foreach ($path in $paths) {
        Write-Host $path
        #get files in folder older than deleteTime
        $temp1 = Get-ChildItem -Path $path | Where-Object {$_.LastWriteTime -lt $limit} | Select-Object -Expand Name  #this has 5 files in list
        Write-Host $temp1
 
        #will delete every other file
        foreach ($temp in $temp1){
            Write-Host "removing $temp" #prints correct file names to screen
            Remove-Item $path$temp -Force

            "File deleted: $temp from $path" | Out-File -FilePath C:\logs\deletedlog.txt -Append
        }
    }
} Catch [Exception] {
    "Something went wrong here, if i had to hazard a guess, it would be the developers fault" | Out-File -FilePath C:\logs\faultlog.txt -Append
}