# UnTrap for YouTube

Safari extension that strips YouTube of Shorts, the home-page recommendation grid, related videos, comments, and other chrome so you can watch without the feed pulling you back in.

Toolbar button toggles blocking per tab. Closed eye = distractions hidden. Open eye = YouTube as usual.

## Install (Safari 26+)

1. Clone this repo.
2. Safari → **Settings** → **Advanced** → enable **Show features for web developers**.
3. Safari → **Settings** → **Developer** → enable **Allow unsigned extensions**.
4. Click **Add Temporary Extension…** and select this folder (the one with `manifest.json`).
5. Safari → **Settings** → **Extensions** → enable **UnTrap for YouTube**.
6. Grant it access to YouTube when prompted.

Temporary extensions unload when Safari quits. Add it again after relaunch, or keep the folder in:

```
~/Library/Containers/com.apple.Safari/Data/Library/Safari/MagicExtensions/
```

Then enable it under Safari → **Settings** → **Extensions**.
