# UnTrap for YouTube

Safari extension that strips YouTube of Shorts, the home-page recommendation grid, related videos, comments, and other chrome so you can watch without the feed pulling you back in.

Toolbar button toggles blocking per tab. Closed eye = distractions hidden. Open eye = YouTube as usual.

## Install (Safari 26+)

Safari only loads Magic Extensions that are registered in its database. Cloning the folder is not enough.

Quit Safari, then:

```sh
curl -fsSL https://raw.githubusercontent.com/karolbystrek/UnTrap-for-YouTube/main/install.sh | sh
```

Open Safari → **Settings** → **Extensions** → enable **UnTrap for YouTube**. Grant YouTube access when prompted.

To update later:

```sh
git -C "$HOME/Library/Containers/com.apple.Safari/Data/Library/Safari/MagicExtensions/UnTrap-for-YouTube" pull
```
