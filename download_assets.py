import os
import urllib.request

base_url = "https://www.vamshi.email"

assets = [
    # root assets
    ("/favicon.png", "favicon.png"),
    ("/avatar.png", "avatar.png"),
    
    # listening cover arts
    ("/listening/driving-dwllrs.jpg", "listening/driving-dwllrs.jpg"),
    ("/listening/creep-radiohead.jpg", "listening/creep-radiohead.jpg"),
    ("/listening/back-to-friends-sombr.jpg", "listening/back-to-friends-sombr.jpg"),
    ("/listening/apocalypse-cigarettes-after-sex.jpg", "listening/apocalypse-cigarettes-after-sex.jpg"),
    ("/listening/off-my-mind-joe-p.jpg", "listening/off-my-mind-joe-p.jpg"),
    ("/listening/now-i-know-you-bennett-coast.jpg", "listening/now-i-know-you-bennett-coast.jpg"),
    ("/listening/cigarette-daydreams-cage-the-elephant.jpg", "listening/cigarette-daydreams-cage-the-elephant.jpg"),
    ("/listening/superman-mishaal-tamer.jpg", "listening/superman-mishaal-tamer.jpg"),
    ("/listening/brown-eyes-and-backwoods-tom-the-mail-man.jpg", "listening/brown-eyes-and-backwoods-tom-the-mail-man.jpg"),
    ("/listening/tattoos-artemas.jpg", "listening/tattoos-artemas.jpg"),
    ("/listening/love-again-the-kid-laroi.jpg", "listening/love-again-the-kid-laroi.jpg"),
    ("/listening/feeling-whitney-post-malone.jpg", "listening/feeling-whitney-post-malone.jpg"),
    ("/listening/twenty-seven-ethan-marc.jpg", "listening/twenty-seven-ethan-marc.jpg"),
    ("/listening/the-color-violet-tory-lanez.jpg", "listening/the-color-violet-tory-lanez.jpg"),
    ("/listening/travelling-alone-tom-the-mail-man.jpg", "listening/travelling-alone-tom-the-mail-man.jpg"),
    
    # photos
    ("/photos/group-photo.png", "photos/group-photo.png"),
    ("/photos/photo-2.png", "photos/photo-2.png"),
    ("/photos/photo-3.png", "photos/photo-3.png"),
    ("/photos/photo-4.png", "photos/photo-4.png"),
]

print("Starting asset downloads...")
for path, dest in assets:
    dest_dir = os.path.dirname(dest)
    if dest_dir and not os.path.exists(dest_dir):
        os.makedirs(dest_dir)
        print(f"Created directory: {dest_dir}")
        
    url = base_url + path
    print(f"Downloading {url} to {dest}...")
    try:
        urllib.request.urlretrieve(url, dest)
        print(f"Successfully downloaded {dest}")
    except Exception as e:
        print(f"Failed to download {url}: {e}")

print("All downloads finished!")
