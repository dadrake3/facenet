set flag to do shell script "/Users/daryldrake/daryldrake/bin/python /Users/daryldrake/Desktop/CS_Projects/Active/face_id_facenet_fork/facenet/src/face_id/face_id.py --c"

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
