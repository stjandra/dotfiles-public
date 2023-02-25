#!/bin/sh

#################################################################################
# List of path to be added for bash, zsh, and fish shell                        #
#                                                                               #
# 'my_path' is a function defined in .bazshrc (bash/zsh) or config.fish (fish). #
#################################################################################

my_path "$HOME/git/scripts-public"
my_path "$HOME/.local/bin"

is_macos && my_path "$HOME/.jenv/bin"
is_macos && my_path "$HOME/.rbenv/shims"
is_macos && my_path "/usr/local/sbin" # brew

# Go
has_go && [ -n "$GOPATH" ] && my_path "$GOPATH/bin"
has_go && [ -n "$GOROOT" ] && my_path "$GOROOT/bin"
