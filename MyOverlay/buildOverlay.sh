rm Overlay.flata
rm myoverlays.apk.u
rm myoverlays.apk

aapt2 compile -v --dir res/ -o Overlay.flata
aapt2 link -v --no-resource-removal \
-I ~/AppData/Local/Android/Sdk/platforms/android-31/android.jar \
--manifest AndroidManifest.xml \
-o myoverlays.apk.u Overlay.flata
zipalign 4 myoverlays.apk.u myoverlays.apk
printf 'android' | jarsigner -keystore ~/.android/debug.keystore  myoverlays.apk androiddebugkey

adb root
adb remount
adb push myoverlays.apk product/overlay