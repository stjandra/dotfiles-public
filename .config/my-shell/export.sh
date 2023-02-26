#!/bin/sh

###################################################################################
# List of environment variable for bash, zsh, and fish shell                      #
#                                                                                 #
# 'my_export' is a function defined in .bazshrc (bash/zsh) or config.fish (fish). #
###################################################################################

my_export GPG_TTY "$(tty)"
my_export EDITOR "nvim"

# FZF to also consider dotfiles.
my_export FZF_DEFAULT_COMMAND "find ."
my_export FZF_CTRL_T_COMMAND  "find ."

has_go && is_macos && my_export GOPATH "$HOME/go"
# Calling brew takes a few seconds
#has_go && is_macos && my_export GOROOT "$(brew --prefix golang)/libexec"
has_go && is_macos && my_export GOROOT "/usr/local/opt/go/libexec"

has_cmd lesspipe.sh && my_export LESSOPEN '|lesspipe.sh %s'

# Set the $SHELL variable, useful for vim and vifm to know which shell to use.
is_linux && my_export SHELL /usr/bin/fish
is_macos && my_export SHELL /usr/local/bin/fish

# The following line could be changed by ~/git/scripts-public/change_theme
# Please be careful when changing
my_export MYTHEME "macchiato"

# Colors from https://github.com/catppuccin/fzf
[ "$MYTHEME" = "latte" ] && my_export FZF_DEFAULT_OPTS "\
    --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
    --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
    --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"

# Colors from https://github.com/catppuccin/fzf
[ "$MYTHEME" = "macchiato" ] && my_export FZF_DEFAULT_OPTS "\
    --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
    --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
    --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# Colors from https://github.com/ianchesal/nord-fzf
[ "$MYTHEME" = "nord" ] && my_export FZF_DEFAULT_OPTS "\
    --color=bg+:#3b4252,bg:#3b4252,spinner:#b48dac,hl:#81a1c1 \
    --color=fg:#e5e9f0,header:#a3be8b,info:#eacb8a,pointer:#b48dac \
    --color=marker:#a3be8b,fg+:#e5e9f0,prompt:#bf6069,hl+:#81a1c1"

[ "$MYTHEME" = "onedark" ] && my_export FZF_DEFAULT_OPTS "\
    --color=bg+:#3f4451,bg:#3f4451,spinner:#c162de,hl:#8cc265 \
    --color=fg:#e6e6e6,header:#4aa5f0,info:#d18f52,pointer:#c162de \
    --color=marker:#4aa5f0,fg+:#e6e6e6,prompt:#e05561,hl+:#8cc265"
