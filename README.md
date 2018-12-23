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

# C#

Install `libuv`:

```
brew install libuv
```

## Setting up MacVim as script editor in Unity3D

```
defaults write com.unity3d.UnityEditor5.x kScriptsDefaultApp "`eval echo ~/.vim/mvimhelper`"
```

The *mvimhelper* script provided should have execute permissions (`chmod +x ~/.vim/mvimhelper`).
This script opens MacVim via `open` with a valid `mvim://` URL.
This is necessary for MacVim to load with the environment variables you may have set.
Without a proper setup of them, OmniSharp wont work properly.
You can check for loaded environment variables inside MacVim via `:!env`.

In Unity3D, go to `Preferences > External Tools` and set `External Script Editor Args` to:

```
"$(File)" $(Line)
```

# Javascript

Install `node` and `npm`.

Install `standard`:

```
npm install -g standard
```
