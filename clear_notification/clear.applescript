log "Script begin"

tell application "System Events"
	tell process "NotificationCenter"
    repeat while ((count windows) > 0)
      try
        set numwins to (count windows)
        repeat with i from 0 to numwins by 1
          click button "Close" of window i
        end repeat
      error
        -- noop
      end try
    end repeat
	end tell
end tell

log "Script end"
