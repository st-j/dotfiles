# some additional git aliases

# use brewed git, if it exists
if [[ -e /usr/local/bin/git ]]
then
	alias git='/usr/local/bin/git'
fi

# clustergit
alias cgr='clustergit --recursive'
alias cgrp='clustergit --recursive --pull'

# git flow
alias gfl='git flow'
alias gff='git flow feature'
