#!/bin/bash

DOTFILES_TARGET="~/.dotfiles"

# Set up symlink
REPO_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if test ${DOTFILES_TARGET}; then
    echo "${DOTFILES_TARGET} exists."
else
    echo "Linking ~/.dotfiles to ${REPO_DIR}"
    ln -s ${REPO_DIR} ~/.dotfiles
fi

# Set up private directory
PRIVATE_DIR="${REPO_DIR}/private"
mkdir -p ${PRIVATE_DIR}

GITCONFIG_WORK="${PRIVATE_DIR}/gitconfig-work"
if ! test -f ${GITCONFIG_WORK}; then
    cp templates/gitconfig-work ${GITCONFIG_WORK}
    vim ${GITCONFIG_WORK}
fi

# Run dotsync for the first time
${DOTFILES_TARGET}/dotsync/bin/dotsync -L
