#!/bin/sh

# "InputMethod" was supposed to automatically set "QT_IM_MODULE", but it doesn't, so we manually export it.
# GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard
# InputMethod=qtvirtualkeyboard

# Crop image to square:
# mogrify -gravity center -crop 1:1 +repage image.jpg
# Resize face to 256x256:
# mogrify -resize 256x256 image.jpg

# Copy fonts:
# sudo cp -r fonts/{redhat,redhat-vf} /usr/share/fonts/
