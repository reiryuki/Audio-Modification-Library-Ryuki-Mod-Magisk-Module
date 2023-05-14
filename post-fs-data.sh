# ryukimod
# Variables
mount -o rw,remount /data
MODPATH=${0%/*}
API=
moddir=
amldir=

# Functions
set_perm() {
  chown $2:$3 $1 || return 1
  chmod $4 $1 || return 1
  CON=$5
  [ -z $CON ] && CON=u:object_r:system_file:s0
  chcon $CON $1 || return 1
}
set_perm_recursive() {
  find $1 -type d 2>/dev/null | while read dir; do
    set_perm $dir $2 $3 $4 $6
  done
  find $1 -type f -o -type l 2>/dev/null | while read file; do
    set_perm $file $2 $3 $5 $6
  done
}
cp_mv() {
  mkdir -p "$(dirname "$3")"
  cp -af "$2" "$3"
  [ "$1" == "-m" ] && rm -f $2 || true
}
osp_detect() {
  local spaces effects type="$1"
  local files=$(find $MODPATH/system -type f -name "*audio_effects*.conf" -o -name "*audio_effects*.xml")
  for file in $files; do
    for osp in $type; do
      case $file in
        *.conf) spaces=$(sed -n "/^output_session_processing {/,/^}/ {/^ *$osp {/p}" $file | sed -r "s/( *).*/\1/")
                effects=$(sed -n "/^output_session_processing {/,/^}/ {/^$spaces\$osp {/,/^$spaces}/p}" $file | grep -E "^$spaces +[A-Za-z]+" | sed -r "s/( *.*) .*/\1/g")
                for effect in ${effects}; do
                  spaces=$(sed -n "/^effects {/,/^}/ {/^ *$effect {/p}" $file | sed -r "s/( *).*/\1/")
                  [ "$effect" != "atmos" -a "$effect" != "dtsaudio" ] && sed -i "/^effects {/,/^}/ {/^$spaces$effect {/,/^$spaces}/d}" $file
                done
                ;;
        *.xml) effects=$(sed -n "/^ *<postprocess>$/,/^ *<\/postprocess>$/ {/^ *<stream type=\"$osp\">$/,/^ *<\/stream>$/ {/<stream type=\"$osp\">/d; /<\/stream>/d; s/<apply effect=\"//g; s/\"\/>//g; s/ *//g; p}}" $file)
                for effect in ${effects}; do
                  [ "$effect" != "atmos" -a "$effect" != "dtsaudio" ] && sed -i "/^\( *\)<apply effect=\"$effect\"\/>/d" $file
                done
                ;;
      esac
    done
  done
  return 0
}

# Debug
exec 2>$MODPATH/debug-pfsd.log
set -x

# ryukimod
# Paths
MAGISKPATH=`magisk --path`
if [ "$MAGISKPATH" ]; then
  MAGISKTMP=$MAGISKPATH/.magisk
  MIRROR=$MAGISKTMP/mirror
  ODM=$MIRROR/odm
  MY_PRODUCT=$MIRROR/my_product
fi
SYSTEMPATH=`realpath /system`
VENDORPATH=`realpath /vendor`
ODMPATH=`realpath /odm`
MY_PRODUCTPATH=`realpath /my_product`

# Restore and reset
. $MODPATH/uninstall.sh
rm -rf $amldir $MODPATH/system $MODPATH/errors.txt $MODPATH/system.prop
[ -f "$moddir/acdb/post-fs-data.sh" ] && mv -f $moddir/acdb/post-fs-data.sh $moddir/acdb/post-fs-data.sh.bak
mkdir $amldir
# ryukimod
# Don't follow symlinks
lists="*audio*effects*.conf -o -name *audio*effects*.xml\
       -o -name *policy*.conf -o -name *policy*.xml\
       -o -name *mixer*paths*.xml -o -name *mixer*gains*.xml\
       -o -name *audio*device*.xml -o -name *sapa*feature*.xml\
       -o -name *audio*platform*info*.xml -o -name *audio*configs*.xml"
files="$(find $SYSTEMPATH $VENDORPATH $ODMPATH $MY_PRODUCTPATH -type f -name $lists)"
for file in $files; do
  name=$(echo "$file" | sed -e "s|/system_root/|/|" -e "s|/system/|/|")
  cp_mv -c $file $MODPATH/system$name
  modfiles="/system$name $modfiles"
done
if [ ! -d $ODM ]; then
  files="$(find /odm -type f -name $lists)"
  for file in $files; do
    name=$(echo "$file" | sed -e "s|/odm||")
    cp_mv -c $file $MODPATH/system/vendor$name
  done
fi
if [ ! -d $MY_PRODUCT ]; then
  files="$(find /my_product -type f -name $lists)"
  for file in $files; do
    name=$(echo "$file" | sed -e "s|/my_product/||")
    cp_mv -c $file $MODPATH/system/vendor$name
  done
fi
osp_detect "music"

# Detect/move audio mod files
for mod in $(find $moddir/* -maxdepth 0 -type d ! -name aml); do
  modname="$(basename $mod)"
  [ -f "$mod/disable" ] && continue
  # ryukimod
  # Move files
  files="$(find $mod/system -type f -name $lists 2>/dev/null)"
  [ "$files" ] && echo "$modname" >> $amldir/modlist || continue
  for file in $files; do
    cp_mv -m $file $amldir/$modname/$(echo "$file" | sed "s|$mod/||")
  done
  # Chcon fix for Android Q+
  [ $API -ge 29 ] && chcon -R u:object_r:vendor_file:s0 $mod/system/vendor/lib*/soundfx 2>/dev/null
done

# Remove unneeded files from aml
for file in $modfiles; do
  [ "$(find $amldir -type f -path "*$file")" ] || rm -f $MODPATH$file
done

# ryukimod
# Set perms and such
set_perm_recursive $MODPATH/system 0 0 0755 0644
if [ $API -ge 26 ]; then
  set_perm_recursive $MODPATH/system/vendor 0 2000 0755 0644 u:object_r:vendor_file:s0
  set_perm_recursive $MODPATH/system/vendor/etc 0 2000 0755 0644 u:object_r:vendor_configs_file:s0
  set_perm_recursive $MODPATH/system/vendor/odm/etc 0 2000 0755 0644 u:object_r:vendor_configs_file:s0
  set_perm_recursive $MODPATH/system/odm/etc 0 0 0755 0644 u:object_r:vendor_configs_file:s0
fi
exit 0
