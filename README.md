# Fresh setup

Make sure `~/.vim` doesn't exist

```
git clone --recursive https://github.com/frarees/dotvim.git ~/.vim
```

# C#

Download OmniSharp Roslyn server:

```
sh ~/download-omnisharp-roslyn.sh
```

Install `libuv`:

```
brew install libuv
```

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
