# Example Plugin

This `example.sh` script acts as an example Spin plugin for testing Spin plugin functionality.
It is referenced in the [example.json manifest](example.json).

> Note: This plugin only lives within the Spin plugins repository for testing purposes.
> Most plugins should be developed and built in their own repository with only the manifest living in Spin Plugins.

To recreate:

1. Package and zip it by running `tar czvf example.tar.gz example example.license`.
2. Get checksum: `shasum -a 256 example.tar.gz`.
3. Modify plugin manifest to use the correct checksum.

## Installing and using the plugin

The plugin can be installed from either a remote or local manifest.
Install the plugin from a remote manifest using `--url`.

```sh
spin plugin install --url https://raw.githubusercontent.com/fermyon/spin-plugins/main/example/example.json
```

Or, install the plugin from a local manifest using `--file`.

```sh
curl -LO https://raw.githubusercontent.com/fermyon/spin-plugins/main/example/example.json
spin plugin install --file example.json
```

Once installed, the plugin can be executed as a Spin CLI subcommand.

```sh
spin example
# Output: This is an example Spin plugin!
```
