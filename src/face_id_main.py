from face_id.face_id import server, client
import sys

if __name__ == "__main__":


    if sys.argv[1] == '--s':
        #with tf.Session() as sess:
        server()

    elif sys.argv[1] == '--c':
        client()