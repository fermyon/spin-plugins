# Example Plugin

This `example.sh` script acts as an example Spin plugin for testing Spin plugin functionality.
It is referenced in the [example.json manifest](../manifests/example/example.json).

> Note: This plugin only lives within the Spin plugins repository for testing purposes.
> Most plugins should be developed and built in their own repository with only the manifest living in Spin Plugins.

To recreate:

1. Package and zip it by running `tar czvf example.tar.gz example.sh example.license`.
2. Get checksum: `shasum -a 256 example.tar.gz`.
3. Modify plugin manifest to use the correct checksum.
