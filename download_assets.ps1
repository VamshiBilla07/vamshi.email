$baseUrl = "https://www.adit.email"
$assets = @(
    @("/favicon.png", "favicon.png"),
    @("/avatar.png", "avatar.png"),
    @("/listening/driving-dwllrs.jpg", "listening/driving-dwllrs.jpg"),
    @("/listening/creep-radiohead.jpg", "listening/creep-radiohead.jpg"),
    @("/listening/back-to-friends-sombr.jpg", "listening/back-to-friends-sombr.jpg"),
    @("/listening/apocalypse-cigarettes-after-sex.jpg", "listening/apocalypse-cigarettes-after-sex.jpg"),
    @("/listening/off-my-mind-joe-p.jpg", "listening/off-my-mind-joe-p.jpg"),
    @("/listening/now-i-know-you-bennett-coast.jpg", "listening/now-i-know-you-bennett-coast.jpg"),
    @("/listening/cigarette-daydreams-cage-the-elephant.jpg", "listening/cigarette-daydreams-cage-the-elephant.jpg"),
    @("/listening/superman-mishaal-tamer.jpg", "listening/superman-mishaal-tamer.jpg"),
    @("/listening/brown-eyes-and-backwoods-tom-the-mail-man.jpg", "listening/brown-eyes-and-backwoods-tom-the-mail-man.jpg"),
    @("/listening/tattoos-artemas.jpg", "listening/tattoos-artemas.jpg"),
    @("/listening/love-again-the-kid-laroi.jpg", "listening/love-again-the-kid-laroi.jpg"),
    @("/listening/feeling-whitney-post-malone.jpg", "listening/feeling-whitney-post-malone.jpg"),
    @("/listening/twenty-seven-ethan-marc.jpg", "listening/twenty-seven-ethan-marc.jpg"),
    @("/listening/the-color-violet-tory-lanez.jpg", "listening/the-color-violet-tory-lanez.jpg"),
    @("/listening/travelling-alone-tom-the-mail-man.jpg", "listening/travelling-alone-tom-the-mail-man.jpg"),
    @("/photos/group-photo.png", "photos/group-photo.png"),
    @("/photos/photo-2.png", "photos/photo-2.png"),
    @("/photos/photo-3.png", "photos/photo-3.png"),
    @("/photos/photo-4.png", "photos/photo-4.png")
)

Write-Host "Starting downloads..."
foreach ($asset in $assets) {
    $url = $baseUrl + $asset[0]
    $dest = $asset[1]
    
    $parent = Split-Path -Path $dest -Parent
    if ($parent -and !(Test-Path -Path $parent)) {
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
        Write-Host "Created directory: $parent"
    }
    
    Write-Host "Downloading $url to $dest..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -TimeoutSec 15
        Write-Host "Success: $dest"
    } catch {
        $err = $_
        Write-Warning "Failed to download $url - error: $err"
    }
}
Write-Host "Finished downloads!"
