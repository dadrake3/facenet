from face_id.face_id import server, client
from multiprocessing import freeze_support
import sys

if __name__ == "__main__":
	freeze_support()

	if sys.argv[1] == '--s':
		server()
	elif sys.argv[1] == '--c':
		client()