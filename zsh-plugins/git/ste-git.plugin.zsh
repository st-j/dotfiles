# some additional git aliases

# use brewed git, if it exists
if [[ -e /usr/local/bin/git ]]
then
	alias git='/usr/local/bin/git'
fi

# clustergit
alias cgr='clustergit --recursive'
alias cgrp='clustergit --recursive --pull'
