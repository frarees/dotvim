# Fresh setup

Make sure `~/.vim` doesn't exist. 

```
git clone --recursive https://github.com/frarees/dotvim.git ~/.vim
```
# Powerline fonts

```
sh ~/.vim/powerline-fonts/install.sh
```

## OSX Terminal vim

```
sh ~/.vim/terminal-fonts.sh
```

# C# and Unity3D

Choose:

1. Use Unity3D's embeeded mono. 
2. Install `mono` and set `MONO_PATH` and `MONO_MONODOCS`

__Unity3D__: Include the following lines to your `.bash_profile`

v5.3 and older

```
UNITY_PATH=/Applications/Unity/Unity.app

export PATH=$UNITY_PATH/Contents/Frameworks/MonoBleedingEdge/bin:$PATH
export MONO_PATH=$UNITY_PATH/Contents/Frameworks/Managed:$UNITY_PATH/Contents/Frameworks/MonoBleedingEdge/lib/mono/4.5
```

v5.4 and newer

```
export PATH=$UNITY_PATH/Contents/MonoBleedingEdge/bin:$PATH
export MONO_PATH=$UNITY_PATH/Contents/Managed:$UNITY_PATH/Contents/MonoBleedingEdge/lib/mono/4.5:$UNITY_PATH/Contents/Mono/lib/mono/2.0
```

Compile OmniSharp Server:

```
xbuild ~/.vim/omnisharp-server/OmniSharp.sln
```

# Javascript

Install `node` and `npm`. Install `standard`:

```
npm install -g standard
```

# PICO-8

Include the following lines to your `.bash_profile`

```
export PICO_PATH=/Applications/PICO-8.app/Contents/MacOS/pico8
```

