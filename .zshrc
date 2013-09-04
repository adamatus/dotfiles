# Setup prompt, based on oh-my-zsh theme

#setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevarS

if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi

# Apply theming defaults
PS1="%n@%m:%~%# "

# Setup the prompt with pretty colors
setopt prompt_subst

CURRENT_BG='NONE'
SEGMENT_SEPARATOR='⮀'

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown
# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`
  local host=`hostname`
  local bg=black
  local fg=default

  if [[ "$user" == "$DEFAULT_USER" ]]; then
    case "$host" in 
      *.local|serenity)
        bg=black
        ;;
      teuber|luria|pm|postlematlab)
        bg=black
        fg=cyan
        ;;
      *)
        bg=black
        fg=magenta
        ;;
    esac
    prompt_segment $bg $fg "%(!.%{%F{yellow}%}.)%m"
  else
    prompt_segment $bg $fg "%(!.%{%F{yellow}%}.)$user@%m"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue black '%~'
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_context
  prompt_dir
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '

# Customize to your needs...
export PATH=/usr/texbin:/usr/local/afni:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/Users/adam/bin:/Users/adam/bin/scripts:/usr/games

if [ -d /usr/local/freesurfer ]
then
  export FREESURFER_HOME=/usr/local/freesurfer
  source $FREESURFER_HOME/SetUpFreeSurfer.sh > /dev/null
  export SUBJECTS_DIR=/shared/surfaces
  export FUNCTIONALS_DIR=/shared/surfaces/funcs
fi
#
# Setup caret if installed
if [ -d /usr/local/caret ]
then
    export PATH=$PATH:/usr/local/caret/bin_linux64
    export PATH=$PATH:/usr/local/caret/bin_macosx64
fi

# Enable vi-mode
function zle-keymap-select zle-line-init zle-line-finish {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi

  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

bindkey -v

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
fi

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# define right prompt, if it wasn't defined by a theme
if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPS1='$(vi_mode_prompt_info)'
fi

# Turn off autocorrect, because I know how to actually type
unsetopt correct_all

# Speed up escape key sequence timeout (in ms)
bindkey -rpM viins '^['

# Allow for extended pattern matching
setopt extendedglob 

# Change to a directory without requiring cd
setopt AUTO_CD

export EDITOR="vim"

# Homebrew needs a tmp folder on the same volume (NFS mount) as Cellar
export HOMEBREW_TEMP=/usr/local/tmp

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward  

# Enable jumpstat (haven't got it going yet on Ubuntu)
if [[ `uname` == 'Darwin' ]]; then
    [[ -f `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
fi

# Need to use g-prefixed coreutils when in OS X
if [[ `uname` == 'Darwin' ]]; then
    eval $(gdircolors ~/.dir-colors)
    export LS_COMMAND='gls'
else
    eval $(dircolors ~/.dir-colors)
    export LS_COMMAND='ls'
fi 

# Setup proper dir colors 
export LS_OPTIONS='--color'

# Quick and dirty file listings
alias ls='$LS_COMMAND $LS_OPTIONS'
alias ll='$LS_COMMAND -l $LS_OPTIONS'
alias ltr='$LS_COMMAND -ltr $LS_OPTIONS'
alias lt='$LS_COMMAND -lt $LS_OPTIONS'
alias lta='$LS_COMMAND -lta $LS_OPTIONS'
 
# Can't be bothered to type the 'm'...
alias vi="vim"
 
# Can't break my muscle memory for top...
alias top="htop"

# Color grep results
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
 
# Setup network shortcuts
alias pm='ssh -Y -l adam pm'
alias teuber='ssh -Y -l adam teuber.psych.wisc.edu'
alias luria='ssh -Y -l adam luria.psych.wisc.edu'
alias hebb='ssh -Y -l adamr hebb.psych.wisc.edu'
#alias mutt='nocorrect mutt'

# Super user
alias _='sudo'
alias please='sudo'

# Allow us to rename long directories quickly
# TODO Doesn't seem to be working
namedir () { $1=$PWD ;  : ~$1 }

# Setup directory history
DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome
alias dh='dirs -v'

alias mn='matlab -nodesktop -nosplash'

#Show progress while file is copying
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"

if [ -d /usr/local/fmri_tools ]; then
    export PYTHONPATH=/usr/local/fmri_tools/lib
    export PATH=$PATH:/usr/local/fmri_tools/bin
fi
