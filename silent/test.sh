# QT_IM_MODULE=qtvirtualkeyboard sddm-greeter --test-mode --theme . &
# wf-recorder --file=test.mp4 -g "1600,0 1920x1080"

QT_IM_MODULE=qtvirtualkeyboard QML2_IMPORT_PATH=./components/ sddm-greeter-qt6 --test-mode --theme .
