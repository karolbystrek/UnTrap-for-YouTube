# UnTrap for YouTube

Safari extension that strips YouTube of Shorts, the home-page recommendation grid, related videos, comments, and other chrome so you can watch without the feed pulling you back in.

Toolbar button toggles blocking per tab. Closed eye = distractions hidden. Open eye = YouTube as usual.

## Install (Safari 26+)

Quit Safari, then:

```sh
git -C "$HOME/Library/Containers/com.apple.Safari/Data/Library/Safari/MagicExtensions" clone https://github.com/karolbystrek/UnTrap-for-YouTube.git
```

Open Safari → **Settings** → **Extensions** → enable **UnTrap for YouTube**. Grant YouTube access when prompted.

To update later:

```sh
git -C "$HOME/Library/Containers/com.apple.Safari/Data/Library/Safari/MagicExtensions/UnTrap-for-YouTube" pull
```
