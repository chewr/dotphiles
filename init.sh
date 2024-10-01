#!/bin/bash

DOTFILES_TARGET="${HOME}/.dotfiles"

echo "Dotfiles target: ${DOTFILES_TARGET}"

# Set up symlink
REPO_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if test -d ${DOTFILES_TARGET} || test -L ${DOTFILES_TARGET}; then
    echo "${DOTFILES_TARGET} exists."
else
    echo "Linking ${DOTFILES_TARGET} to ${REPO_DIR}"
    ln -s ${REPO_DIR} ${DOTFILES_TARGET}
    sleep 0.5
fi

# Set up private directory
PRIVATE_DIR="${REPO_DIR}/private"
mkdir -p ${PRIVATE_DIR}

# TODO: read user input for templating as much of this as possible
setup_config() {
    CONF_FILE="${1}"
    TARGET_PATH="${PRIVATE_DIR}/${CONF_FILE}"
    if ! test -f ${TARGET_PATH}; then
	    cp templates/${CONF_FILE} ${TARGET_PATH}
	    vim ${TARGET_PATH}
    fi
}

# Set workmode or homemode
setup_config "dotfiles-config"

source ${PRIVATE_DIR}/dotfiles-config
if [[ "${IS_WORKMODE}" = "true" ]]; then
    setup_config "gitconfig-work"
    setup_config "zshrc-work"
fi

# Run dotsync for the first time
${DOTFILES_TARGET}/dotsync/bin/dotsync -L
