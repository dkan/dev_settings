alias ls='ls -aFG'
alias pg='postgres -D /usr/local/var/postgres'
alias redis='redis-server /usr/local/etc/redis.conf'
alias elasticsearch='elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'
alias grep='grep -n --color'
alias deletemerged='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'


export GIT_EDITOR=vim
export EDITOR=vim

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules,vendor}/*"'

export CLICOLOR=1
export LSCOLORS=exgxfxdxcxdxdxaccxaeex

export PATH="/usr/local/bin:${PATH}"

export PATH="$PATH:/usr/local/bin"
export GOPATH=~/Documents/Development/golang
export PATH=$PATH:$GOPATH/bin

export HISTCONTROL=ignorespace
export HISTFILESIZE=1000000000
export HISTSIZE=1000000
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

function parse_git_branch {
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%f '
zstyle ':vcs_info:*' enable git

PROMPT='%F{white}%T %F{green}%0~%f ${vcs_info_msg_0_}%# '

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
