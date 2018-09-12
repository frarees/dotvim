#!/bin/sh
rm -rf $(dirname $0)/omnisharp-roslyn && mkdir -p $(dirname $0)/omnisharp-roslyn && curl -s https://api.github.com/repos/OmniSharp/omnisharp-roslyn/releases/tags/v1.32.1 | python $(dirname $0)/get-url-omnisharp-roslyn.py | xargs curl -sL | tar xzf - -C $(dirname $0)/omnisharp-roslyn
