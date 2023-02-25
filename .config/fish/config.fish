###############
# fish Config #
###############

# Do not load unnecessary config during non interactive for faster skhd
# https://github.com/koekeishiya/skhd/issues/101
if not status --is-interactive
	exit
end

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

function my_alias -d 'Create an abbrv.' -a name command
    abbr -g $name $command
end

function my_path -d "Add path." -a path
    fish_add_path $argv
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

# https://github.com/ivakyb/fish_ssh_agent
function __ssh_agent_is_started -d "check if ssh agent is already started"
   if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
      source $SSH_ENV > /dev/null
   end

   if test -z "$SSH_AGENT_PID"
      return 1
   end

   ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep -q ssh-agent
   #pgrep ssh-agent
   return $status
end

# https://github.com/ivakyb/fish_ssh_agent
function __ssh_agent_start -d "start a new ssh agent"
   ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
   chmod 600 $SSH_ENV
   source $SSH_ENV > /dev/null
   true  # suppress errors from setenv, i.e. set -gx
end

# https://github.com/ivakyb/fish_ssh_agent
function fish_ssh_agent --description "Start ssh-agent if not started yet, or uses already started ssh-agent."
   if test -z "$SSH_ENV"
      set -xg SSH_ENV $HOME/.ssh/environment
   end

   if not __ssh_agent_is_started
      __ssh_agent_start
   end
end

# Adapted from https://github.com/gokcehan/lf/blob/master/etc/lfcd.fish
function lfcd
    set tmp (mktemp)
    lf_ueberzug -last-dir-path=$tmp $argv
    if test -f "$tmp"
        set dir (cat $tmp)
        rm -f $tmp
        if test -d "$dir"
            if test "$dir" != (pwd)
                cd $dir
            end
        end
    end
end

function has_cmd
    command -v "$argv" 1>/dev/null 2>&1
end

########
# PATH #
########

source $HOME/.config/my-shell/path.sh

###############
# Environment #
###############

if is_arch
    fish_ssh_agent
end

# Supresses fish intro greeting.
set fish_greeting

set GPG_TTY (tty)

# FZF to also consider dotfiles.
set FZF_DEFAULT_COMMAND 'find .'
set FZF_CTRL_T_COMMAND  'find .'

set -gx EDITOR 'nvim'

if has_go
    if is_macos
        set -gx GOPATH "$HOME/go"
        set -gx GOROOT "(brew --prefix golang)/libexec"
    end
end

# Set the $SHELL variable, useful for vim and vifm to know which shell to use.
if is_macos
    set SHELL /usr/local/bin/fish
else if is_linux
    set SHELL /usr/bin/fish
end

# pyenv init.
if has_cmd pyenv
  pyenv init - | source
end

# Enable less to open compressed files .gz, etc.
if has_cmd lesspipe.sh
    export LESSOPEN='|lesspipe.sh %s'
end

# Source work config.
if test -e $HOME/.config/my-work/config.fish
    source $HOME/.config/my-work/config.fish
end

if is_macos

    # Need C-o for neomutt binding
    # https://apple.stackexchange.com/a/3255
    stty discard undef

    # Need C-y for neomutt binding
    # https://stackoverflow.com/a/46310328
    stty dsusp undef
end

###########
# Aliases #
###########

source $HOME/.config/my-shell/aliases.sh

# Fish specific aliases.
my_alias so "source $HOME/.config/fish/config.fish" # Reload fish config.

###########
# Start X #
###########

if is_linux
    # https://wiki.archlinux.org/title/Fish#Start_X_at_login
    # Start X at login
    if status is-login
        if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
            exec startx -- -keeptty
        end
    end
end
