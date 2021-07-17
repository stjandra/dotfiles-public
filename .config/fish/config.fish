###############
# fish Config #
###############

#############
# Functions #
#############

function cdg -d 'Go to a dir in $HOME/git' -a dir
    if not test -n "$dir"
        set dir ""
    end
    cd $HOME/git/$dir
end

function cdc -d 'Go to a dir in $HOME/.config' -a dir
    if not test -n "$dir"
        set dir ""
    end
    cd $HOME/.config/$dir
end

function is_kitty
    test -n $TERM && test "$TERM" = "xterm-kitty"
end

function my_alias -d 'Create an abbrv.'
    # If 3 args:
    #   $argv[1]: condition
    #   $argv[2]: alias name
    #   $argv[3]: command
    # If 2 args: Set command $argv[2] to abbreviation $argv[1]
    switch (count $argv)
        case 3
            my_alias_conditional $argv[1] $argv[2] $argv[3]
        case 2
            abbr -g $argv[1] $argv[2]
        case '*'
            echo "Invalid my_alias args"
    end
end

function my_alias_conditional -d 'Create an abbrv if the condition is satisfied.' -a condition name command
    # If $condition is true, set $command to abbreviation $name
    if $condition
        my_alias $name $command
    end
end

function fish_prompt --description 'Write out the prompt'
    # Mostly the default fish_prompt function with minor changes.

    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
    end

    # Add username and host if running via ssh.
    set -l color_host $fish_color_host
    set -l host_prompt ''
    if set -q SSH_TTY
        set color_host $fish_color_host_remote
        set host_prompt (set_color $fish_color_user) "$USER" $normal @ (set_color $color_host) (prompt_hostname) $normal ' '
    end

    # Write pipestatus
    # If the status was carried over (e.g. after `set`), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" (set_color $fish_color_status) (set_color $bold_flag $fish_color_status) $last_pipestatus)

    echo -n -s $host_prompt (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status 🐙 " "
end

# Override the one defined in /usr/share/fish/functions/fish_title.fish
function fish_title
    # emacs' "term" is basically the only term that can't handle it.
    if not set -q INSIDE_EMACS; or string match -vq '*,term:*' -- $INSIDE_EMACS
        # An override for the current command is passed as the first parameter.
        # This is used by `fg` to show the true process name, among others.

        # Substitute $HOME with ~
        echo (set -q argv[1] && echo $argv[1] || status current-command) (__fish_pwd | sed "s|$HOME|~|")
    end
end

########
# PATH #
########

fish_add_path $HOME/git/scripts-public

if is_macos
    fish_add_path $HOME/.jenv/bin
    fish_add_path $HOME/.rbenv/shims
    fish_add_path /usr/local/opt/mysql@5.7/bin
    fish_add_path /Applications/kdiff3.app/Contents/MacOS
    fish_add_path /usr/local/sbin # brew
else if is_linux
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/git/jenv/bin
    fish_add_path /opt/mysql-5.7.32-linux-glibc2.12-x86_64/bin
end

###############
# Environment #
###############

# Supresses fish intro greeting.
set fish_greeting

set GPG_TTY (tty)

# FZF to also consider dotfiles.
set FZF_DEFAULT_COMMAND 'find .'
set FZF_CTRL_T_COMMAND  'find .'

# kitty only.
if is_kitty

    # Set the $SHELL variable, useful for vim and vifm to know which shell to use.
    if is_macos
        set SHELL /usr/local/bin/fish
    else if is_linux
        set SHELL /usr/bin/fish
    end
end

# pyenv init.
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

# Enable less to open compressed files .gz etc.
if is_linux
    export LESSOPEN="| /usr/bin/lesspipe %s";
    export LESSCLOSE="/usr/bin/lesspipe %s %s";
end

# jenv init on macOS.
if type -q jenv
    if is_macos
        # From https://www.reddit.com/r/fishshell/comments/hs4dh3/anyone_using_jenv_under_fish_shell_im_getting_a/
        status --is-interactive; and jenv init - fish | source
    end
end

# Source work config.
source $HOME/.config/my-work/config.fish

###########
# Aliases #
###########

source $HOME/.config/my-shell/aliases.config

# Fish specific aliases.
my_alias so "source $HOME/.config/fish/config.fish" # Reload fish config.

#if is_kitty
#    # Cannot use abbr because some abbr use ssh.
#    alias ssh "TERM=xterm command ssh"
#end
