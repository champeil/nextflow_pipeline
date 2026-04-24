#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
env_prefix="$(cd "${script_dir}/.." && pwd)"
mcr_root="${env_prefix}/share/mcr-8.3-0/v83"

export LD_LIBRARY_PATH="${env_prefix}/lib:${mcr_root}/runtime/glnxa64:${mcr_root}/bin/glnxa64:${mcr_root}/sys/os/glnxa64:${LD_LIBRARY_PATH:-}"

exec "${env_prefix}/share/gistic2-2.0.23-1/gp_gistic2_from_seg" "$@"
