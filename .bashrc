##########################################################################
# bash Config.                                                           #
#                                                                        #
# Most of the configs are in a common file sourced by both bash and zsh: #
#   $HOME/.config/my-shell/.bazshrc                                      #
##########################################################################

source "$HOME/.config/my-shell/.bazshrc"

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
mysource "$HOME/.config/my-work/.bazshrc"

###########
# Start X #
###########

if is_linux; then
    # TODO move to .bash_profile
    # https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login
    if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
        exec startx
    fi
fi
