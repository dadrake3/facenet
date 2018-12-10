# FaceID for macOS 10.14.1


This is a custom implementation of Apples FaceID feature using Google ["FaceNet"](https://github.com/davidsandberg/facenet) run as a Launch Daemon service provider. Uses a ["SleepWatcher"](https://www.bernhard-baehr.de) Launch Daemon to call a client Apple / Bash script on screen wake. Uses Pyro4 with a nameserver to host the tensorflow facnet as a Daemon. Client Apple / Bash script can also be called from ["BetterTouchTools"](https://folivora.ai) to provide FaceID password entry to any app with trackpad gestures.  
. 


## Setup

**WARNING**
Build script is still under development, use at your own risk!

Requires:
-   homebrew
-   python3.6 


1) Follow ["LFA Validation"](https://github.com/davidsandberg/facenet/wiki/Validate-on-lfw) to get facenet running on your machine with a current frozen version of the model. Update the path to the model in face_id/face.py line 49.

2) Follow ["Custom Facenet Classifier"](https://github.com/davidsandberg/facenet/wiki/Train-a-classifier-on-own-images) to train a classifier on your own images. For you will need to align you images using the first guide. I used a training set of ten images of myself from different angles in a folder labeled with my name, and several images from the LFA set in a different folder labeled unknown. Update the path to the classifier in /face_id/face.p line 50.

3) Follow ["SleepWatcher"](https://www.kodiakskorner.com/log/258) to get SleepWatcher installed on your system.

4) Update the client and server .plst files to reflect correct script locations and then place both in /Library/LaunchDaemons.

5) Update face_id_client.scpt to use you password

6) Update face.py and face_id_server.py to set the path if necessary. Also change the classier label to whatever you used when training your classier. 

## Compatibility
The code was developed using Tensorflow r1.12 under macOS 10.14.1 with Python 3.6. 


## Performance
Performs inference in roughly 2-3 seconds, feels natural with IOS faceid. Using the server client model allowed us to get rid of the startup overhead from reimporting the dependencies and the Tensorflow model. Shaved about 6 seconds off total runtime.


## Tools usedf

- Activity Monitor
- Script Editor
- Automator for script timing
- Pycharm
- Homebrew
- Py2app, exfreeze, pyinstaller

## ToDO
0) Add client launch daemons for login and for screen savor dismiss
1) Add support for auto filling password while logged in
2) Create a build script.
3) Add support for multiple users.
4) Add web cam overlay to login screen.
5) Add support for detecting eye gaze
6) Use a cnn to predict image depth then run detect face from pre-processing on the rgbd image, if it cant bound a face then they're probably using a image
7) Add travis online build verifier

this output might help with keychain 
ioreg -b -r -n AppleKeyStore


