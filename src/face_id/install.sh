#!/usr/bin/env bash

# get root access
sudo su

# get the code
cd ~
git clone https://github.com/dadrake3/facenet.git
cd facenet/src/face_id


# install requirements
python -m pip install -r ../../requirements.txt
brew install sleepwatcher


## THIS NEEDS TO BE FIXED ##

# select user data set
oascript "choose folder with prompt "Please choose a file:""

# select unknown data set
oascript "choose folder with prompt "Please choose a file:""

# train classifier and get models

# align data
for N in {1..4}; do python src/align/align_dataset_mtcnn.py \
~/datasets/lfw/raw \
~/datasets/lfw/lfw_mtcnnpy_160 \
--image_size 160 \
--margin 32 \
--random_order \
--gpu_memory_fraction 0.25 \
& done

python src/classifier.py TRAIN ~/datasets/my_dataset/train/ ~/models/model-20170216-091149.pb ~/models/my_classifier.pkl --batch_size 1000

# remove as no longer needed
rm ~/datasets/lfw/lfw_mtcnnpy_160

# use these to change the paths in face.py
face_py_path = $PWD/face.py
classifier_model_path =
sed -i -e 's/CLASSIFER_MODEL_PATH/$classifier_model_path/g' face_py_path

##  ##

# fix the daemons

# fix client paths
client_scpt_path = $PWD/face_id_client.scpt
sed -i -e 's/CLIENT_APPLE_SCRIPT_PATH/$client_scpt_path/g' ./de.ddrake.face-id.client.plist
cp ./de.ddrake.face-id.client.plist /Library/LaunchDaemons/de.ddrake.face-id.client.plist


# fix server paths
python = which pyhton
server_py_path = $PWD/face_id_server.sh
server_sh_path = $PWD/face_id_server.sh


sed -i -e 's/USER_PYTHON/$python/g' server_sh_path
sed -i -e 's/FACE_ID_PYTHON_SERVER_PATH/$server_py_path/g' server_sh_path

sed -i -e 's/FACE_ID_SERVER_SCRIPT_PATH/$server_sh_path/g' ./de.ddrake.face-id.server.plist
cp ./de.ddrake.face-id.client.plist /Library/LaunchDaemons/de.ddrake.face-id.client.plist


# launch the daemons
launchctl unload /Library/LaunchDaemons/de.ddrake.face-id.server.plist
launchctl unload /Library/LaunchDaemons/de.ddrake.face-id.client.plist

launchctl load /Library/LaunchDaemons/de.ddrake.face-id.server.plist
launchctl load /Library/LaunchDaemons/de.ddrake.face-id.client.plist