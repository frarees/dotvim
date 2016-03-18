# Fresh setup

Make sure `~/.vim` doesn't exist. 

```
git clone --recursive https://github.com/frarees/dotvim.git ~/.vim
```

# Omnisharp server

```
xbuild ~/.vim/omnisharp-server/OmniSharp.sln
```

## Using Unity's Mono

Include the following line to your `.bash_profile`

```
export MONO_PATH=/Applications/Unity/Unity.app/Contents/Frameworks/Managed:/Applications/Unity/Unity.app/Contents/Frameworks/Mono/lib/mono/2.0
```

