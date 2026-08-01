# Audio Modification Library Ryuki Mod Magisk Module

## Descriptions
- Audio Modification Library (AML) is a compatibility framework originally created by zackptg5 & ahrion https://github.com/Zackptg5/Audio-Modification-Library that allows the seamless integration of multiple audio mods for Magisk installs. Enables supported audio mods to share the same needed files sudo as audio_effects.
- More details: https://forum.xda-developers.com/apps/magisk/mod-audio-modification-library-t3745466 but this is just a documentation and I am not there.
- I will not add built-in support for soundfx that are not yet registered in AudioModificationLibrary.sh in this module. So if your soundfx module is not yet registered in AudioModificationLibrary.sh, then you must add aml.sh file to your module so that your soundfx can work with this module.
- patch_cfgs function is no longer relevant since now there is 64 bit only ROM, so you have to create your script independently in your aml.sh without the patch_cfgs function.
- To uninstall, PLEASE REMOVE VIA MAGISK/KERNELSU/APATCH/KITSUNE MASK APP ONLY

## Changelog

v1.3_RM
- Resets module folders/files permissions at post-fs-data
- Fix wrong logic at uninstall.sh
- Revert unnecessary changes

v1.2_RM
- /data/adb/modules/nomount/disable detection

v1.1_RM
- Support NoMount metamodule

v1.0_RM (v5.1_ryukimod.9)
- Fix wrong target in latest KernelSU

v5.1_ryukimod.8
- Exclude \*audio\*effects\*haptic\*.xml

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

## Ryuki Mod Version Adventages
- Support newer Magisk version
- Support NoMount metamodule
- /odm/etc/ & /my_product/etc/ audio files mount bind support in Magisk official
- Fix audio service restarts on some weird ROMs
- Support any module that copies audio files via post-fs-data.sh instead of customize.sh
- Does not copy/modify \*audio\*effects\*spatializer\*.xml and \*audio\*effects\*haptic\*.xml that causes conflict
- Prevent /data modifying failure in some devices
- Prevent command failure caused by selinux denial
- No need to reinstall if Android SDK API version is changed nor if switched from Magisk official to Magisk Delta/Kitsune Mask and vice-versa
- Fix bugs & permissions

## Ryuki Mod Version Download Link
Update via Magisk/KernelSU/Apatch app is still directed to official version, so the Ryuki Mod version can only be updated/downloaded from here: https://bicolink.com/otXQuoFKg

## Download Tutorial
https://t.me/ryukinotes/97

## Support & Bug Report
- https://t.me/ryukinotes/54
- If you don't do above, issues will be closed immediately

## Credits and Contributors
- @ShadoV90
- @itsmax_18
- @M73trz
- https://t.me/viperatmos
- https://t.me/androidryukimodsdiscussions
- You can contribute ideas about this Magisk Module here: https://t.me/androidappsportdevelopment
