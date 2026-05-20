#!/usr/bin/env bash
set -euo pipefail

# Utils
BLUE="\e[1;34m"
RED="\e[1;31m"
RESET="\e[0m"

log() {
  echo -e "${BLUE}[CI]${RESET} $1"
}

fail() {
  echo -e "${RED}[FAIL]${RESET} $1"
  exit 1
}

# build
log "Building project..."
make clean >/dev/null 2>&1 || true # fail is alright
make >/dev/null 2>&1
[[ -x ./mdriver ]] || fail "mdriver not build!"

# test
tests=(
  "short1-bal.rep"
  "short2-bal.rep"
  )
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

for rep in "${tests[@]}"; do
  log "run ./mdriver -V -f $rep"
  mylog="$tmpdir/${rep}.log"

  if ./mdriver -V -f "$rep" >"$mylog" 2>&1; then
    log "PASS $rep"
  else
    status=$?
    log "FAIL $rep (exit=$status)"
    log "-----$rep log begin-----"
    cat "$mylog"
    log "----- $rep log end -----"
    exit "$status"
  fi
done

