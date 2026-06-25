#!/usr/bin/env bash
# Guard: the kent formula must install prebuilt binaries (release archives /
# bottles), never compile from source. A source build means `brew install kent`
# silently falls back to a full toolchain build whenever a bottle is missing,
# which has regressed releases before. The kent repo enforces the same invariant
# on the generator scripts/update-brew-tap.sh.
set -euo pipefail

formula="$(cd "$(dirname "${0}")/.." && pwd)/Formula/kent.rb"

if [[ ! -f "${formula}" ]]; then
  echo "ERROR: ${formula} not found" >&2
  exit 1
fi

fail=0
while IFS= read -r marker; do
  if grep -qF -- "${marker}" "${formula}"; then
    echo "ERROR: Formula/kent.rb contains source-build marker: ${marker}" >&2
    fail=1
  fi
done << 'MARKERS'
scripts/build.sh
go build
=> :build
system "go"
MARKERS

if ! grep -qF 'bin.install' "${formula}"; then
  echo "ERROR: Formula/kent.rb must install a prebuilt binary (bin.install missing)" >&2
  fail=1
fi

if [[ "${fail}" -ne 0 ]]; then
  echo "kent formula must install prebuilt binaries only; see scripts/check-kent-prebuilt.sh" >&2
  exit 1
fi

echo "OK: Formula/kent.rb installs prebuilt binaries only"
