# Audio Modification Library Ryuki Mod Magisk Module
Audio Modification Library (AML) is a compatibility framework originally created by zackptg5 & ahrion that allows the seamless integration of multiple audio mods for Magisk installs. Enables supported audio mods to share the same needed files sudo as audio_effects. [More details in support thread](https://forum.xda-developers.com/apps/magisk/mod-audio-modification-library-t3745466).<br/>
To uninstall, PLEASE REMOVE VIA MAGISK/KERNELSU APP ONLY

## Changelog
* See [Changelog](changelog.md)

## Source Code
* Module [GitHub](https://github.com/Zackptg5/Audio-Modification-Library)

## Ryuki Mod Version Adventages
* android.hardware.audio@4.0-service-mediatek restart support
* /odm/etc/ & /my_product/etc/ audio files mount bind support in Magisk official
* Support module that copies audio files via post-fs-data.sh instead of customize.sh
* Does not copy/modify \*audio\*effects\*spatializer\*.xml that causes conflict in audio flinger
* Prevent /data modifying failure in some devices
* Prevent command failure caused by selinux denial
* Does not need to reinstall if Android SDK API version is changed or if switched from Magisk official to Magisk Delta and vice-versa
* Fix bugs & permissions

## Ryuki Mod Version Download Link and Changelog
* Update via Magisk/KernelSU app is still directed to official version, so the Ryuki Mod version can only be updated/downloaded from here: https://www.pling.com/p/1981006/


