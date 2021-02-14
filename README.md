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
  "FormattingOptions": {
    "EnableEditorConfigSupport": true
  }
}
```

Unity: Analyzers support needs to be set up per project (`<project-path>/omnisharp.json`):

```json
{
  "RoslynExtensionsOptions": {
    "enableAnalyzersSupport": true,
    "locationPaths": [
      "Library/Analyzers"
    ]
  }
}
```

Manually place `Microsoft.Unity.Analyzers.dll` inside `./Library/Analyzers`. You can set up other paths too.

In the future, [Easy Editor](https://github.com/frarees/easyeditor) will handle the OmniSharp configuration file for Unity projects, and set up analyzers automatically.

# Unity's dotnet

Add the following exports to your profile (`.zprofile`, `.bash_profile`, ...). **Pay attention to version numbers, and match your current installation accordingly.**.

```
export DOTNET_ROOT=/Applications/Unity/Hub/Editor/2020.2.3f1/Unity.app/Contents/NetCore/Sdk-2.2.107
export PATH=$PATH:$DOTNET_ROOT
export PATH=$PATH:/Applications/Unity/Hub/Editor/2020.2.3f1/Unity.app/Contents/MonoBleedingEdge/bin
export FrameworkPathOverride=/Applications/Unity/Hub/Editor/2020.2.3f1/Unity.app/Contents/MonoBleedingEdge/lib/mono/4.7.1-api
export MSBuildSDKsPath=/Applications/Unity/Hub/Editor/2020.2.3f1/Unity.app/Contents/NetCore/Sdk-2.2.107/sdk
```

# Vim-based editors in Unity

Use [Easy Editor](https://github.com/frarees/easyeditor).

