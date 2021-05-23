##########################################################################
# bash Config.                                                           #
#                                                                        #
# Most of the configs are in a common file sourced by both bash and zsh: #
#   $HOME/.config/my-shell/.bazshrc                                      #
##########################################################################

# Disable "Can't follow non-constant source.
# Use a directive to specify location." warning.
# shellcheck disable=SC1090

source "$HOME/.config/my-shell/.bazshrc"

##################
# Terminal Title #
##################

# Kitty: Set tab title to working directory.
if is_kitty; then
    if [[ $PROMPT_COMMAND != *"title_pwd"* ]]; then
        PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND"}'title_pwd'
    fi
fi

##########
# Prompt #
##########

# export PS1="\h:\W \u\$" # Mac default

# Add username and host if running via ssh.
HOST_PROMPT=''
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    HOST_PROMPT="\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;33m\]\h "
fi

export PS1="$HOST_PROMPT\[\033[01;34m\]\w\[\033[00m\]🦄 "

###############
# Environment #
###############

mysource "$HOME/.fzf.bash"

if is_macos; then
    # enable bash-completion
    mysource "/usr/local/etc/profile.d/bash_completion.sh"

    # Hide ‘default interactive shell is now zsh’
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi

# Source work config.
source "$HOME/.config/my-work/.bazshrc"
