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
  log "run ./mdriver -Vv -f $rep"
  mylog="$tmpdir/${rep}.log"

  if ./mdriver -Vv -f "$rep" >"$mylog" 2>&1; then
    if grep -q "errors" "$mylog"; then
      log "FAIL $rep"
      log "-----$rep log begin-----"
      cat "$mylog"
      log "----- $rep log end -----"
      exit 1
    fi
    log "PASS $rep"
  else
    log "FAIL $rep"
    log "-----$rep log begin-----"
    cat "$mylog"
    log "----- $rep log end -----"
    exit 2
  fi
done

