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
2. Install `mono` and set `MONO_PATH` if you do in a custom path. 

__Unity3D__: Include the following lines to your `.bash_profile`

```
UNITY_PATH=/Applications/Unity/Unity.app

export PATH=$UNITY_PATH/Contents/Frameworks/MonoBleedingEdge/bin:$PATH
export MONO_PATH=$UNITY_PATH/Contents/Frameworks/Managed:$UNITY_PATH/Contents/Frameworks/MonoBleedingEdge/lib/mono/4.5
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

