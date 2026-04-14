# Audio Modification Library Ryuki Mod Magisk Module

## Descriptions
- Audio Modification Library (AML) is a compatibility framework originally created by zackptg5 & ahrion https://github.com/Zackptg5/Audio-Modification-Library that allows the seamless integration of multiple audio mods for Magisk installs. Enables supported audio mods to share the same needed files sudo as audio_effects.
- To uninstall, PLEASE REMOVE VIA MAGISK/KERNELSU APP ONLY

## Changelog

v1.0_RM (v5.1_ryukimod.9)
- Fix wrong target in latest KernelSU

v5.1_ryukimod.8
- Exclude audioeffectshaptic.xml

v5.1_ryukimod.7
- Mount bind file only if the original file is exist

v5.1_ryukimod.6
- Fix audio service restarts in some weird ROMs

v5.1_ryukimod.5
- Magisk v28 compatibility

v5.1_ryukimod.4
- Fix conflict with modules_update while installing via recovery if Magisk installed

v5.1_ryukimod.3
- Redirect /sdcard to /data/media/"$UID"
- Restarts android.hardware.audio@4.0-service-mediatek for all SDK API

v5.1_ryukimod.2
- Restarts android.hardware.audio@4.0-service-mediatek
- Add optional debug.log=1 for more detailed install log

v5.1_ryukimod
- Save install log at /sdcard/..._recovery.log if installing via Recovery
- Does not require reinstall if Android SDK API is changed
- Fix bug in KernelSU
- Fix permissions
- Fix selinux denial

v5.0_ryukimod
- Fix uninstallation
- Fix bug in KernelSU

## Ryuki Mod Version Adventages
- Support newer Magisk version
- /odm/etc/ & /my_product/etc/ audio files mount bind support in Magisk official
- Fix audio service restarts on some weird ROMs
- Support any module that copies audio files via post-fs-data.sh instead of customize.sh
- Does not copy/modify \*audio\*effects\*spatializer\*.xml and \*audio\*effects\*haptic\*.xml that causes conflict
- Prevent /data modifying failure in some devices
- Prevent command failure caused by selinux denial
- No need to reinstall if Android SDK API version is changed nor if switched from Magisk official to Magisk Delta/Kitsune Mask and vice-versa
- Fix bugs & permissions

## Ryuki Mod Version Download Link
Update via Magisk/KernelSU app is still directed to official version, so the Ryuki Mod version can only be updated/downloaded from here: 

## Support & Bug Report
- https://t.me/ryukinotes/54
- If you don't do above, issues will be closed immediately

## Credits and Contributors
- @ShadoV90
- https://t.me/viperatmos
- https://t.me/androidryukimodsdiscussions
- You can contribute ideas about this Magisk Module here: https://t.me/androidappsportdevelopment
