#!/usr/bin/env bash
set -euo pipefail

target="${1:-/out/WXS_env}"
archive="${ENV_ARCHIVE:-/opt/artifacts/WXS_env.tar.gz}"

if [[ ! -f "${archive}" ]]; then
  echo "Missing packed environment archive: ${archive}" >&2
  exit 1
fi

mkdir -p "${target}"
tar -xzf "${archive}" -C "${target}"

if [[ -x "${target}/bin/conda-unpack" ]]; then
  "${target}/bin/conda-unpack"
fi

echo "Environment exported to ${target}"
