# Some devices fails to modify /data at this time without remounting
mount -o rw,remount /data

# Variables
MODPATH="${0%/*}"
amldir=
API=
filenames="*audio*effects*.conf -o -name *audio*effects*.xml\
           -o -name *policy*.conf -o -name *policy*.xml\
           -o -name *mixer*paths*.xml -o -name *mixer*gains*.xml\
           -o -name *audio*device*.xml -o -name *sapa*feature*.xml\
           -o -name *audio*platform*info*.xml -o -name *audio*configs*.xml"

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
  local files=$(find $MODPATH -type f -name "*audio*effects*.conf" -o -name "*audio*effects*.xml")
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

# Restore and reset
. $MODPATH/uninstall.sh
moddir="$(dirname $MODPATH)" # Changed by uninstall script
rm -rf $amldir $(find $MODPATH/system $MODPATH/vendor -type f) $MODPATH/errors.txt $MODPATH/system.prop 2>/dev/null
[ -f "$moddir/acdb/post-fs-data.sh" ] && mv -f $moddir/acdb/post-fs-data.sh $moddir/acdb/post-fs-data.sh.bak
mkdir $amldir
# Don't follow symlinks
files="$(find /system /odm /my_product -type f -name $filenames)"
for file in $files; do
  name=$(echo "$file" | sed 's|/system||g')
  cp_mv -c $file $MODPATH/system$name
done
files="$(find /vendor -type f -name $filenames)"
for file in $files; do
  if [ -L $MODPATH/system/vendor ]\
  && [ -d $MODPATH/vendor ]; then
    cp_mv -c $file $MODPATH$file
  else
    cp_mv -c $file $MODPATH/system$file
  fi
done
rm -f `find $MODPATH -type f -name *audio*effects*spatializer*.xml`
osp_detect "music"

# Detect/move audio mod files
for mod in $(find $moddir/* -maxdepth 0 -type d ! -name aml -a ! -name 'lost+found'); do
  modname="$(basename $mod)"
  [ -f "$mod/disable" ] && continue
  # Move files
  files="$(find $mod -type f -name $filenames 2>/dev/null)"
  [ "$files" ] && echo "$modname" >> $amldir/modlist || continue
  for file in $files; do
    cp_mv -m $file $amldir/$modname$(echo "$file" | sed "s|$mod||g")
  done
  # Chcon fix for Android Q+
  if [ $API -ge 29 ]; then
    if [ -L $mod/system/vendor ] && [ -d $mod/vendor ]; then
      chcon -R u:object_r:vendor_file:s0 $mod/vendor/lib*/soundfx 2>/dev/null
    else
      chcon -R u:object_r:vendor_file:s0 $mod/system/vendor/lib*/soundfx 2>/dev/null
    fi
  fi
done

# Set perms and such
if [ $API -ge 26 ]; then
  set_perm_recursive $MODPATH/system/odm/etc 0 0 0755 0644 u:object_r:vendor_configs_file:s0
  if [ -L $MODPATH/system/vendor ]\
  && [ -d $MODPATH/vendor ]; then
    set_perm_recursive $MODPATH/vendor 0 2000 0755 0644 u:object_r:vendor_file:s0
    set_perm_recursive $MODPATH/vendor/etc 0 2000 0755 0644 u:object_r:vendor_configs_file:s0
    set_perm_recursive $MODPATH/vendor/odm/etc 0 2000 0755 0644 u:object_r:vendor_configs_file:s0
  else
    set_perm_recursive $MODPATH/system/vendor 0 2000 0755 0644 u:object_r:vendor_file:s0
    set_perm_recursive $MODPATH/system/vendor/etc 0 2000 0755 0644 u:object_r:vendor_configs_file:s0
    set_perm_recursive $MODPATH/system/vendor/odm/etc 0 2000 0755 0644 u:object_r:vendor_configs_file:s0
  fi
fi
exit 0







