# Fresh setup

Make sure `~/.vim` doesn't exist, and get the dotfiles:

```
git clone --recursive https://github.com/frarees/dotvim.git ~/.vim
```

Let `vim-plug` install the plugins using `:PlugInstall`:

```
vim -c 'PlugInstall'
```

# Fonts

```
brew tap homebrew/cask-fonts
brew install --cask font-fira-mono
```

# OmniSharp

Install via:

```
vim -c 'set ft=cs' -c 'OmniSharpInstall'
```

Set the config file in `~/.omnisharp/omnisharp.json`:

```json
{
  "cake": {
     "enabled": false
  },
  "script": {
     "enabled": false
  },
  "RoslynExtensionsOptions": {
    "enableAnalyzersSupport": true
  },
  "FormattingOptions": {
    "EnableEditorConfigSupport": true
  }
}
```

# Vim-based editors in Unity

Use [Easy Editor](https://github.com/frarees/easyeditor).

If you invoke an editor instance on your own, make sure it has a valid `FrameworkPathOverride` environment variable loaded.

Export it into your shell profile (`.zprofile`, `.bash_profile`, ...):

```
export FrameworkPathOverride=/Applications/Unity/Hub/Editor/2020.2.3f1/Unity.app/Contents/MonoBleedingEdge/lib/mono/4.7.1-api
```

**NOTE: Match your current Unity installation path.**

