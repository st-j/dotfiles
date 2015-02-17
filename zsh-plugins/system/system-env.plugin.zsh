export EDITOR='st'

# /usr/local/bin needs to be in the path *before* /usr/bin
# (because, e.g., brew otherwise fails during the upgrade of py
# packages because it finds the native python first)
export PATH=$HOME/bin:/Applications/Racket\ v6.1.1/bin/:$HOME/.gem/ruby/2.0.0/bin:/usr/local/bin:$PATH

# required for MacTex
eval `/usr/libexec/path_helper -s`

# some directory bookmarks
export UNRISK_SRC=$HOME/SCM/Work/Finance/unrisk

# added by perl
PERL_MB_OPT="--install_base \"/Users/stefan/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/stefan/perl5"; export PERL_MM_OPT;
