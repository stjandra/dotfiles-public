##########################################################################
# zsh Config.                                                            #
#                                                                        #
# Most of the configs are in a common file sourced by both bash and zsh: #
#   $HOME/.config/my-shell/.bazshrc                                      #
##########################################################################

source $HOME/.config/my-shell/.bazshrc

##################
# Terminal Title #
##################

# Kitty: Set tab title to working directory.
if is_kitty; then
    function precmd() {
        title_pwd
    }
fi

##########
# Prompt #
##########

# Add username and host if running via ssh.
HOST_PROMPT=''
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    HOST_PROMPT="%F{green}%n%f@%F{yellow}%m%f "
fi

export PROMPT="$HOST_PROMPT%F{magenta}%~%f🐽 "

###############
# Environment #
###############

mysource "$HOME/.fzf.zsh"

# Source work config.
mysource $HOME/.config/my-work/.bazshrc

################
# Key Bindings #
################

if is_macos; then
    # Alt + left/right arrow: Move between words.
    bindkey "^[[1;3C" forward-word
    bindkey "^[[1;3D" backward-word
fi
