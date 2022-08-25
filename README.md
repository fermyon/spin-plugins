# Spin Plugin Manifests

This repository acts as an index for hosting spin-maintained and community-maintained manifests for Spin plugins. These plugins can be installed via the Spin CLI with the `spin plugin install $name` command. By default, Spin will look for a plugin manifest named `$name.json` in the this repository; however, Spin can also directed to use a local manifest or one at a different remote location using the `--file` or `--url` flag, respectively.

## What is a Spin plugin manifest?

A Spin plugin is defined by a Spin plugin manifest, which is a JSON file that conforms to the [Spin plugin manifest schema](./json-schema/spin-plugin-manifest-schema-0.1.json). A plugin manifest defines a plugin’s name, version, license, homepage (i.e. GitHub repo), compatible Spin version, and gives a short description of the plugin. It also points to the plugin source for various operating systems and platforms.

## Adding a Spin plugin manifest

To add a manifest for a plugin named `$name` to this index, run `./create-manifest.sh $name`, which creates a new subfolder `manifests/$name` and adds the manifest to it. Modify the example manifest to fit your plugin, being sure to note [naming conventions](#spin-plugin-naming-conventions) and [compatibility with Spin](#plugin-compatibility).

### Spin Plugin Naming Conventions

The following naming conventions are to be followed for plugins where `$name` is the name of the plugin.

- The `name` field in the plugin manifest must be `$name`.
- Even if the majority of plugins live within the Spin plugins repository, there is a need to distinguish between plugins that are maintained by Spin vs community plugins. They will be distinguished via the plugin name inside the manifest. The name of community plugins must not have "spin" as a prefix, while plugins maintained by Spin should contain a prefix of `spin-`.
- Manifests for older versions of the plugin can be retained in the Spin Plugins repository named `$name@$version.json` where `$version` is the value of the `version` field of the manifest. These specific versions can be installed using the `--version` flag.
- The binary of the plugin must be named `$name`
- The latest plugin manifest file must be named `$name.json`
- The license for the plugin must be named `$name.license`

### Plugin Compatibility

Spin plugins must specify compatible versions of Spin in the `spinCompatibility` field of the manifest. The field is expected to be a list of rules, with each rule being a [comparison operators](https://docs.rs/semver/1.0.13/semver/enum.Op.html) (`=, >, >=, <, <=, ~, ^, *`) along with the compatible version of Spin. The JSON schema validates that the `spinCompatibility` field is a string that matches the following regular expression: `^([><~^*]?[=]?v?(0|[1-9]\d*)(\.(0|[1-9]\d*))?(\.(0|[1-9]\d*))?(-(0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*)?(\+[0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*)?)(?:, *([><~^*]?[=]?v?(0|[1-9]\d*)(\.(0|[1-9]\d*))?(\.(0|[1-9]\d*))?(-(0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*)?(\+[0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*)?))*$`.
For example, specifying `=0.4` means that the plugin is compatible with versions equivalent to `>=0.4.0, <0.5.0`. Multiple rules may be specified (i.e. `>=0.2, <0.5`).

Spin will use the [`semver`](https://docs.rs/semver/1.0.13/semver/struct.VersionReq.html) crate that inspired this syntax to verify that the plugin works on the current version of Spin. If it does not, it will fail to install the plugin and log a message explaining the version mismatch.

## Validating Plugin Schemas

A plugin schema can be validated locally using any JSON schema validator. The spin plugins GitHub workflow that must succeed before a plugin is merged uses [ajv](https://ajv.js.org/), which can also be run locally as follows:

1. Install [`ajv-cli`](https://www.npmjs.com/package/ajv-cli)
1. Get the current schema used by spin and validate all json plugin manifests against it:

    ```sh
    export JSON_SCHEMA_VERSION=$(cat json-schema/version.txt)
    ajv -s json-schema/spin-plugin-manifest-schema-$JSON_SCHEMA_VERSION.json -d "manifests/*/*.json" --spec=draft2019
    ```
