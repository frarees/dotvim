# Fresh setup

Make sure `~/.vim` doesn't exist

```
git clone --recursive https://github.com/frarees/dotvim.git ~/.vim
```

# C#

Download OmniSharp Roslyn server:

```
sh ~/.vim/download-omnisharp-roslyn.sh
```

or

```
sh ~/.vim/download-omnisharp-roslyn-stable.sh
```

Install `libuv`:

```
brew install libuv
```

__Note: it is no longer required to use Unity's embeeded mono, as we're forced to install mono to use Visual Studio__

Set `MONO_PATH` on your `.bash_profile`:

Unity3D v5.4 and newer

```
UNITY_PATH=/Applications/Unity/Unity.app

export PATH=$UNITY_PATH/Contents/MonoBleedingEdge/bin:$PATH
export MONO_PATH=$UNITY_PATH/Contents/Managed:$UNITY_PATH/Contents/MonoBleedingEdge/lib/mono/4.5:$UNITY_PATH/Contents/Mono/lib/mono/2.0
```

Unity3D v5.3 and older

```
UNITY_PATH=/Applications/Unity/Unity.app

export PATH=$UNITY_PATH/Contents/Frameworks/MonoBleedingEdge/bin:$PATH
export MONO_PATH=$UNITY_PATH/Contents/Frameworks/Managed:$UNITY_PATH/Contents/Frameworks/MonoBleedingEdge/lib/mono/4.5
```

## Setting up vim as script editor

__Note that Visual Studio is recommended as default script editor, as it is responsible for sln generation__

To set MacVim as the script editor on Unity3D:

```
defaults write com.unity3d.UnityEditor5.x kScriptsDefaultApp "/Applications/MacVim.app/Contents/bin/mvim"
```

In Unity3D, go to `Preferences > External Tools` and set `External Script Editor Args` to `--remote-tab-silent +$(Line) "$(File)"`

# Javascript

Install `node` and `npm`.

Install `standard`:

```
npm install -g standard
```
