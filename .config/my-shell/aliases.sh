#!/bin/sh

##################################################################################
# List of aliases (bash/zsh) or abbr (fish).                                     #
#                                                                                #
# 'my_alias' is a function defined in .bazshrc (bash/zsh) or config.fish (fish). #
##################################################################################

my_alias ll    "ls -lGaF"
my_alias llg   "ls -lGaF | grep"
my_alias cdx   "cd $HOME/Dropbox"

# Emacs
# Open emacsclient on terminal
my_alias em "emacsclient --create-frame -nw --socket-name=main"
# Open emacsclient on terminal and go to magit
my_alias eg "emacsclient --create-frame -nw --socket-name=magit -e \"(magit-status)\""

# Neovim
my_alias nv  "nvim"
my_alias nvd "nvim -d"

# LunarVim
my_alias lv "lvim"

# git
# Mostly from https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
my_alias g    "git"
my_alias ga   "git add"
my_alias gaa  "git add --all"
my_alias gb   "git branch"
my_alias gba  "git branch -a"
my_alias gc   "git commit -v"
my_alias gcl  "git clone"
my_alias gco  "git checkout"
my_alias gcp  "git cherry-pick"
my_alias gd   "git diff"
my_alias gds  "git diff --staged"
my_alias gf   "git fetch"
my_alias gfa  "git fetch --all --prune"
my_alias gl   "git pull"
my_alias glg  "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%as) %C(bold blue)<%an>%Creset' --all"
my_alias gl1  "git log -n1"
my_alias gm   "git merge --no-commit"
my_alias gmn  "git merge --no-commit --no-ff"
my_alias gmtl "git mergetool --no-prompt"
my_alias gp   "git push"
my_alias gpsu "git push --set-upstream origin \$(git branch --show-current)"
my_alias gsh  "git show"
my_alias gss  "git status -s"
my_alias gst  "git status"
my_alias gsw  "git switch"
my_alias gswc "git switch -c"
my_alias gswb "git switch \$(git branch -a | fzf | tr -d '[:space:]*')"

# git with fzf
my_alias fgb "git branch -a | fzf | tr -d '[:space:]*'"
my_alias fgs "git status -s | fzf | cut -c 4-"

# hg
my_alias hgbs "hg branches"
my_alias hgb  "hg branch"
my_alias hgd  "hg diff"
my_alias hgl  "hg pull -u"
my_alias hgp  "hg push"
my_alias hgs  "hg serve"

# Change Java version with jenv.
my_alias j8  "jenv global 1.8"
my_alias j11 "jenv global 11.0"
my_alias jv  "java -version"

# mvn
my_alias mcd  "mvn clean deploy"
my_alias mcds "mvn clean deploy -Dmaven.test.skip=true"
my_alias mci  "mvn clean install"
my_alias mcis "mvn clean install -Dmaven.test.skip=true"
my_alias mcp  "mvn clean package"
my_alias mcps "mvn clean package -Dmaven.test.skip=true"

# Prettify JSON.
# https://stackoverflow.com/a/1920585
my_alias pj "python -m json.tool"

# tmux
# in_tmux is a script in scripts-public/
my_alias ta  "tmux attach -t"
my_alias tn  "tmux new-session -t"
my_alias tl  "tmux list-sessions"
my_alias trd "in_tmux && tmux rename-window \$(basename \$PWD)" # Rename tmux window to directory name

#########
# Linux #
#########

is_linux && my_alias lf "lf_ueberzug" # A wrapper script for lf and Ueberzug

##############
# Arch Linux #
##############

# Replace the above jenv aliases with archlinux-java
is_arch && my_alias j8 "sudo archlinux-java set java-8-openjdk"
is_arch && my_alias j11 "sudo archlinux-java set java-11-openjdk"

#########
# macOS #
#########

#########
# Kitty #
#########
is_kitty && my_alias icat  "kitty +kitten icat"
