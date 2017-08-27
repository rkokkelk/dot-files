#############
# Variables #
#############
HISTFILE=$HOME/.zsh/zsh_history
HISTSIZE=1000
SAVEHIST=1000
TERM='xterm-256color'
PATH=$PATH:$HOME/.bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:$HOME/.gem/ruby/2.4.0/bin

export EDITOR=vim
eval `dircolors -b`

#############
# OH-MY-ZSH #
#############
export ZSH=$HOME/.oh-my-zsh
plugins=(git pep8 pylint gpg-agent tmux command-not-found compleat zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

#############
# SSH-Agent #
#############
unset SSH_AGENT_PID
if [ -S "/run/user/$UID/gnupg/S.gpg-agent.ssh" ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
else
  export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
fi

#######
# RVM #
#######
RVM="$home/.rvm/scripts/rvm"
if [ -e $RVM ]
then
  source $RVM
fi

###########
# Options #
###########
setopt hist_ignore_dups
setopt appendhistory 
setopt autocd 
setopt extendedglob 
setopt correctall 
setopt interactivecomments
unsetopt beep

#########
# Regex #
#########
zmodload zsh/regex

###########
# Modules #
###########
autoload -U compinit
autoload -U menu-select
autoload -Uz vcs_info

compinit

#######
# CVS #
#######
zstyle ':vcs_info:*' enable git svn
setopt prompt_subst
precmd() {
	    vcs_info
}
zstyle ':vcs_info:git*' formats "%{$fg[white]%}[%{$fg[blue]%}%b%{$reset_color%}%m%u%c]%{$reset_color%} "

##############
# Completion #
##############

zstyle ':compinstall filename' '/home/roy/.zshrc'
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' menu select=2 

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*' squeeze-slashes true

##########
# Prompt #
##########
  PS1='%K{white}%F{red}%(?..[%?])'\
'%k%F{white}%B%(2L.+.)%(1j.[%j].)'\
'%F{yellow}%(t.Ding!.%~)'\
'%f%k%b%# '
	RPS1='${vcs_info_msg_0_}%B%F{yellow}%*'

###################
# Color Man pages #
###################
export LESS_TERMCAP_mb=$'\E[01;31m'         # begin blinking
export LESS_TERMCAP_md=$'\E[01;37m'         # begin bold
export LESS_TERMCAP_me=$'\E[0m'             # end mode
export LESS_TERMCAP_se=$'\E[0m'             # end standout-mode
export LESS_TERMCAP_so=$'\E[38;246m'      	# begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'             # end underline
export LESS_TERMCAP_us=$'\E[01;34m'         # begin underline

############
# aliasing #
############
if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

########################
# Syntaxt Highlighting #
########################

ZSH_HIGHLIGHT_STYLES[default]='fg=white'

############
# BindKeys #
############
typeset -g -A key
bindkey -v
bindkey '\e[1~' beginning-of-line						# Home
bindkey '\eOH'  beginning-of-line						# Home
bindkey '\e[4~' end-of-line									# End
bindkey '\eOF'  end-of-line									# End
bindkey '\e[5~' beginning-of-history 				# PageUp
bindkey '\e[6~' end-of-history 							# PageDown
bindkey '\e[Z~' reverse-menu-complete 			# Shift+Tab
bindkey '\e[3~' delete-char									# Delete
bindkey '^R' history-incremental-search-backward

#############
# functions #
#############

# Extracts packages
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# Check if sudo is needed
vi(){
  if [ ! -f $1 ]; then
		/usr/bin/vim "$@"
	elif [ -w $1 ]; then
		/usr/bin/vim "$@"
	else
		sudo /usr/bin/vim "$@"
	fi
}

# List content after changing directory
cd(){
  if [ -n "$1" ]; then
    builtin cd "$@" && ls
  else
    builtin cd ~ && ls
  fi
}

svns(){
  PWD=${!#}
  
  if [ ! -d $PWD ]; then
    echo "Please insert directory."
  fi
  
  
  while getopts 'rf' OPTION
    do
      case $OPTION in
      r)
        find $PWD -name '.svn' -type d -print0 | xargs -0 -I remove_dir rm -rf remove_dir ;
        ;;
      f) 
        find $PWD -name '.svn' -type d -print
        ;;
      ?)  printf "Usage %s: [-f] [-r] directory"
        exit 1
        ;;
      esac
  done
}

wiki(){
	dig +short txt $(echo $* | sed 's/ /_/g').wp.dg.cx|sed -E "s/\" \"|^\"|\"$|\\\\//g"|fmt;
}

iptable(){
	if [ $# -gt 0 ]; then
		sudo iptables -t $1 -L -v --line-numbers -n 
	else
		sudo iptables -L -v --line-numbers -n
	fi
}	

ip6table(){
	if [ $# -gt 0 ]; then
		sudo ip6tables -t $1 -L -v --line-numbers -n 
	else
		sudo ip6tables -L -v --line-numbers -n
	fi
}	

# Get external IP
exip () {
    # gather external ip address
    echo -n "Current External IP: "
    curl -s -m 5 http://myip.dk | grep "ha4" | sed -e 's/.*ha4">//g' -e 's/<\/span>.*//g'
}
