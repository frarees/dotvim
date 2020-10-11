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
brew cask install font-fira-mono
```

# OmniSharp

Install via:

```
vim -c 'set ft=cs' -c 'OmniSharpInstall'
```

Add the following export to your profile (`.zprofile`, `.bash_profile`, ...)

```
export FrameworkPathOverride=~/.cache/omnisharp-vim/omnisharp-roslyn/lib/mono/4.5
```

# Vim-based editors in Unity3D

Use [Easy Editor](https://github.com/frarees/easyeditor).


# Go

```
brew install golangci/tap/golangci-lint
```

