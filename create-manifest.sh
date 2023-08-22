#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
NAME=${1:-temp}
echo "Creating a new manifest for Spin plugin ${NAME}."

PLUGIN_DIR="${SCRIPT_DIR}/manifests/${NAME}"
EXAMPLE_PLUGIN="${SCRIPT_DIR}/example/example.json"
mkdir $PLUGIN_DIR
PLUGIN_MANIFEST="${PLUGIN_DIR}/${NAME}.json"
echo "" > $PLUGIN_MANIFEST
sed "s/example/${NAME}/g" $EXAMPLE_PLUGIN > $PLUGIN_MANIFEST
