set flag to do shell script "USER_PYTHON FACE_ID_PYTHON_CLIENT_PATH"

if flag is equal to "True" then
	tell application "System Events"

		keystroke "D96daryl" --password
		delay 1
		key code 52 -- enter
	end tell
else
	display notification "Doubletap to try again if using BTT" with title "FaceID Failed"
	beep

end if
