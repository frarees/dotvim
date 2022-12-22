# Setup

Clone the repository into the vimrc directory.

Unix:

```
git clone https://github.com/frarees/dotvim.git ~/.vim
```

Windows:

```
git clone https://github.com/frarees/dotvim.git ~/vimfiles
```

Install `vim-plug` (see [instructions](https://github.com/junegunn/vim-plug#installation)).

Afterwards, install the plugins:

```
vim -c 'PlugInstall'
```

# Fonts

macOS:

```
brew tap homebrew/cask-fonts
brew install --cask font-fira-mono
```

Windows: download fonts from the [repository](https://github.com/mozilla/Fira).

# OmniSharp

Install via:

```
vim -c 'set ft=cs' -c 'OmniSharpInstall'
```

Set the config file in:

* `~/.omnisharp/omnisharp.json` (Unix)
* `%USERPROFILE%\.omnisharp\omnisharp.json` (Windows)

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

# Unity

Use [Easy Editor](https://github.com/frarees/easyeditor).

