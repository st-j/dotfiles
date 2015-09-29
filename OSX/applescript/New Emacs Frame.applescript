-- http://superuser.com/questions/457484/how-to-open-emacs-from-macs-finder
-- https://gist.github.com/ambethia/304964#comment-799519
on run --{input}
    -- set filepath to quoted form of POSIX path of input
	do shell script "/usr/local/bin/emacsclient -c -n " -- & filepath

    -- bring the visible frame to the front
    tell application "Emacs" to activate

    -- return input
end run