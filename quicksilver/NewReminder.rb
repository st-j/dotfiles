#!/usr/bin/ruby
# as of 0.7.0, chronic has problem with ruby 1.9.3. So use system ruby
require "rubygems"
require "chronic"

AS_GET_LIST = <<-EOF
on run argv
  set listStr to ""
  tell application "Reminders"
    repeat with listIndex from 1 to (count of list)
        set oneList to list listIndex
        if listStr is equal to "" then
            set listStr to (name of oneList)
        else
            set listStr to listStr & "|" & (name of oneList)
        end if
    end repeat
  end tell
  return listStr
end run
EOF

AS_MAKE_REMINDER = <<-EOF
on run argv
  set theList to item 1 of argv
  set theName to item 2 of argv
  if item 3 of argv equal to "" then
    set theDate to ""
  else
    set theDate to date(item 3 of argv)
  end if

  tell application "Reminders"
    tell list theList
      if theDate equal to "" then
        make new reminder with properties {name:theName, body:""}
      else
        make new reminder with properties {name:theName, body:"", due date:theDate}
      end if
    end tell
  end tell
end run
EOF

lists = `osascript -e '#{AS_GET_LIST}'`
lists = lists.strip.split("|") # strip \n, and get ["Life", "Work", ...]

line = ARGV[0].strip
return 1 if !line

parts = line.split("^")
body = parts[0]
date_str = parts.length > 1 ? parts[1] : nil
due_date = Chronic.parse date_str
puts "parsed date string #{due_date}"

due_date_str = due_date ? due_date.strftime("%d/%m/%Y %H:%M") : ""
puts "due date as string #{due_date_str}"

words = body.strip.split(" ")

list = words.find {|w| w.start_with? "@"}
words.delete list

list = lists.find {|l| list.gsub(/^@/, "").upcase.eql? l.upcase} if list
list = lists[0] if !list

`osascript -e '#{AS_MAKE_REMINDER}' #{list} "#{words.join(' ')}" "#{due_date_str}"`

if $?.to_i == 0
  `terminal-notifier -message "#{words.join(' ')}" -title "#{"Reminder @" + list + " " + (due_date ? date_str : "")}" -group new_reminder -activate "com.apple.Reminders"`
else
  `terminal-notifier -message "Oops... Something was wrong" -title "New Reminder" -group new_reminder -activate "com.apple.Reminders"`
end
