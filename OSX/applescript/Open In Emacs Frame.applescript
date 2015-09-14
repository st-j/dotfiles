-- http://superuser.com/questions/457484/how-to-open-emacs-from-macs-finder
-- https://gist.github.com/ambethia/304964#comment-799519
on run {input, parameters}
    -- set filepath to quoted form of POSIX path of input
	set filepath to quoted form of POSIX path of input
	display alert "filepath: " &  filepath
	do shell script "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c -n " & filepath

    -- bring the visible frame to the front
    tell application "Emacs" to activate

    return input
end run
