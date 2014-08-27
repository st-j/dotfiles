export EDITOR='st'

# /usr/local/bin needs to be in the path *before* /usr/bin
# (because, e.g., brew otherwise fails during the upgrade of py
# packages because it finds the native python first)
export PATH=$HOME/bin:/usr/local/bin:$PATH

# required for MacTex
eval `/usr/libexec/path_helper -s`

# some directory bookmarks
export UNRISK_SRC=$HOME/SCM/Work/Finance/unrisk

