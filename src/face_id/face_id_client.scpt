set flag to do shell script "/Users/daryldrake/daryldrake/bin/python /Users/daryldrake/Desktop/CS_Projects/Active/facenet/src/contributed/face_id_client.py "

if flag is equal to "True" then
	tell application "System Events"

		keystroke "******" --password
		delay 1
		key code 52 -- enter
	end tell
else
	display notification "Doubletap to try again" with title "FaceID Failed"

end if
