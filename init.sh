#!/bin/bash

DOTFILES_TARGET="~/.dotfiles"

# Set up symlink
REPO_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if test -f ${DOTFILES_TARGET}; then
    echo "${DOTFILES_TARGET} exists."
else
    echo "Linking ~/.dotfiles to ${REPO_DIR}"
    ln -s ${REPO_DIR} ~/.dotfiles
fi

# Set up private directory
mkdir -p ${REPO_DIR}/private

# Run dotsync for the first time
${DOTFILES_TARGET}/dotsync/bin/dotsync -L
