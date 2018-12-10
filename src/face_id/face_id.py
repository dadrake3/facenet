from __future__ import print_function
import Pyro4
import time
s = time.time()
import sys
import cv2

sys.path.append('./')
import face_id.face as face


@Pyro4.expose
@Pyro4.behavior(instance_mode="single")
class FaceIDServer(object):
    def __init__(self):
        self.frame_interval = 3  # Number of frames after which to run face detection
        self.face_recognition = face.Recognition()
        self.user = 'tommyholcomb'

    def recognize_user(self):
        s = time.time()
        video_capture = cv2.VideoCapture(0)
        is_me = False
        frame_count = 0

        timeout = time.time() + 5  # 5 seconds from now
        while True:
            if time.time() > timeout:
                break

            # Capture frame-by-frame
            ret, frame = video_capture.read()
            faces = []
            if (frame_count % self.frame_interval) == 0:
                faces = self.face_recognition.identify(frame)
                # tf.reset_default_graph()

            frame_count += 1
            # cv2.imshow('Video', frame)

            if faces and faces[0].name == self.user:
                is_me = True
                break

        # K.clear_session()
        video_capture.release()
        # self.face_recognition = None
        print(time.time() - s)
        return is_me

    @Pyro4.oneway
    def reset(self):
        pass

    def __del__(self):
        pass


class FaceIDClient:
    def __init__(self):
        sys.excepthook = Pyro4.util.excepthook
        self.server = Pyro4.Proxy("PYRONAME:face_id.server")

    def recognize_user(self):
        return self.server.recognize_user()


def server():
    Pyro4.Daemon.serveSimple(
            {
                FaceIDServer: "face_id.server"
            },
            ns=True)


def client():
    client = FaceIDClient()
    print(client.recognize_user())


