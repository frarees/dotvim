import json
import sys

release = json.load(sys.stdin)
asset = filter(lambda x: 'http' in x['name'] and 'osx' in x['name'] and 'tar.gz' in x['name'], release['assets'])

print asset[0]['browser_download_url']
