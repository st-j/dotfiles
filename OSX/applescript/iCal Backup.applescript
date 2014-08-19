-- iCal Backup.applescript v1.0
-- Created by John Chaffee, BusyMac LLC, on Nov. 4, 2008
-- Creates an iCal backup file. Script can be launched from an iCal Alarm. You can create a #weAxdk automatic backup.

set timeStamp to do shell script "date \"+%Y-%m-%d %H.%M.%S\""
tell application "Finder" to set myHome to (POSIX path of (path to home folder))

-- Create backup directory in ~/Documentd s/iCal Backups
-- Change this path if you want to store the backups somewhere else
set destDir to myHome & "Backup/iCalDaily"
set fileName to "iCal " & timeStamp
do shell script "mkdir -p " & quoted form of destDir & "/" & quoted form of fileName
set destFile to destDir & "/" & fileName

-- Determine Leopard vs. Tiger
tell application "Finder" to set myVers to get version
if myVers ³ 10.5 then
	set osVers to "Leopard"
else
	set osVers to "Tiger"
end if
global plistVers

-- Create backup files: Copy iCal files from sourceDir to destFile
if osVers = "Leopard" then
	set sourceDir to do shell script "echo ~/Library"
	do shell script "cp -R " & quoted form of sourceDir & "/Calendars " & quoted form of destFile
	do shell script "cd " & quoted form of destFile & "/Calendars; rm -f \"Calendar Cache\"*; rm -r \"Calendar Sync Changes\""
	set plistVers to "2.0"
else
	set sourceDir to do shell script "echo ~/Library/\"Application Support\""
	do shell script "cp -R " & quoted form of sourceDir & "/iCal/ " & quoted form of destFile
	do shell script "cd " & quoted form of destFile & "; rm -f alarmsCache.plist; rm -f sync*.plist"
	set plistVers to "1.0"
end if

-- Create plist file
set plistFile to destFile & "/info.plist"
set plistTime to do shell script "date -u \"+%Y-%m-%dT%H:%M:%SZ\""
set plistContent to "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
	<key>date</key>
	<date>" & plistTime & "</date>
	<key>version</key>
	<string>" & plistVers & "</string>
</dict>
</plist>"
do shell script "echo " & quoted form of plistContent & " > " & quoted form of plistFile

-- Change destFile folder to .icbu suffix
do shell script "mv -f " & quoted form of destFile & " " & quoted form of destFile & ".icbu"

-- Delete backups older than 10 days old
-- Set the deleteAfter variable to the number of days to keep. Anything older will be deleted.
set deleteAfter to 10
set myDir to POSIX file destDir
tell application "Finder"
	set myOldFiles to files in folder myDir where name contains ".icbu" and modification date is less than ((get current date) - deleteAfter * days)
	set myOldFileCount to count of myOldFiles
	repeat with myOldFile in myOldFiles
		delete myOldFile
	end repeat
end tell
twEL