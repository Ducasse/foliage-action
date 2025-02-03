# Foliage GitHub Action
A github action to publish sites made with [foliage](https://github.com/noha/Foliage)


## Example

```yaml
name: publish

on:
  push:
    branches: [ main ]

jobs:
  generate: 
    name: "Generate site"
    runs-on: ubuntu-latest
    steps: 
      - uses: actions/checkout@v2
      - name: "Generate static HTML"
        uses: estebanlm/foliage-action@v1.4
        with:
          source: './site'
          target: 'generated'
      - name: "Upload to server"
        uses: up9cloud/action-rsync@v1.3
        env:
          KEY: ${{secrets.SERVER_SSH_KEY}}
          USER: ${{secrets.REMOTE_USER}}
          HOST: ${{secrets.REMOTE_HOST}}
          TARGET: ${{secrets.REMOTE_TARGET}}
          SOURCE: generated/
```
