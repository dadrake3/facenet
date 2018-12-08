from __future__ import print_function
import sys
import Pyro4.util


def recognize_user(server): return server.recognize_user()


if __name__ == '__main__':

    sys.excepthook = Pyro4.util.excepthook
    face_id_server = Pyro4.Proxy("PYRONAME:face_id.server")
    is_user = recognize_user(face_id_server)
    print(is_user)

