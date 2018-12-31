#!/usr/bin/env bash
_DIR_=$(dirname "$0")

set -e

# shellcheck source=lib/defaults.sh
source "${_DIR_}/lib/defaults.sh"
# shellcheck source=lib/output.sh
source "${_DIR_}/lib/output.sh"
# shellcheck source=lib/funcs.sh
source "${_DIR_}/lib/funcs.sh"

TESTMODE=1

info "running install script"
hl

echo ''

if [ -n "$TESTMODE" ] && [ "$TESTMODE" -gt 0 ]; then
    INSTALL_DIR="${_DIR_}/test"
fi

install_zsh
install_dotfiles
install_homebrew

configure_osx
