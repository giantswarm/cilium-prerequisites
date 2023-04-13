#!/bin/bash
#
# This script syncs cilium network policy and cilium clusterwide network policy CRD from upstream cilium via VERSION=$RELEASE_TAG ./sync.sh
set -euo pipefail

version=${VERSION:-main}
tmp="$(mktemp -d -t cilium.XXXXX)"
upstream=https://github.com/cilium/cilium
script_dir="$( cd "$( dirname "$0" )" && pwd )"


function main() {
    git clone --depth 1 --branch "$version" "$upstream" "$tmp"
    cp -rf "$tmp/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumclusterwidenetworkpolicies.yaml" "$tmp/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumnetworkpolicies.yaml" "$script_dir/../helm/cilium-prerequisites/files/crds/"
}

trap "rm -rf $tmp" EXIT
main

echo "=====> done"