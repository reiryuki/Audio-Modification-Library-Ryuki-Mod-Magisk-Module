# space
ui_print " "

# var
UID=`id -u`
[ ! "$UID" ] && UID=0
[ -z $NVBASE ] && NVBASE=/data/adb

# log
if [ "$BOOTMODE" != true ]; then
  FILE=/data/media/"$UID"/$MODID\_recovery.log
  ui_print "- Log will be saved at $FILE"
  exec 2>$FILE
  ui_print " "
fi

# optionals
OPTIONALS=/data/media/"$UID"/optionals.prop
if [ ! -f $OPTIONALS ]; then
  touch $OPTIONALS
fi

# debug
if [ "`grep_prop debug.log $OPTIONALS`" == 1 ]; then
  ui_print "- The install log will contain detailed information"
  set -x
  ui_print " "
fi

# recovery
if [ "$BOOTMODE" != true ]; then
  MODPATH_UPDATE=`echo $MODPATH | sed 's|modules/|modules_update/|g'`
  rm -f $MODPATH/update
  rm -rf $MODPATH_UPDATE
fi

# info
MODVER=`grep_prop version $MODPATH/module.prop`
MODVERCODE=`grep_prop versionCode $MODPATH/module.prop`
ui_print " ID=$MODID"
ui_print " Version=$MODVER"
ui_print " VersionCode=$MODVERCODE"
if [ "$KSU" == true ]; then
  ui_print " KSUVersion=$KSU_VER"
  ui_print " KSUVersionCode=$KSU_VER_CODE"
  ui_print " KSUKernelVersionCode=$KSU_KERNEL_VER_CODE"
else
  ui_print " MagiskVersion=$MAGISK_VER"
  ui_print " MagiskVersionCode=$MAGISK_VER_CODE"
fi
ui_print " "

# note
ui_print "- Modules detection and patching happens at boot"
ui_print "  The boot script handles everything"
ui_print "  Disabled modules will be ignored"
ui_print " "

# Escape each backslash and space since shell will expand it during echo
sed -i -e 's/\\/\\\\/g' -e 's/\ /\\ /g' $MODPATH/AudioModificationLibrary.sh
# Separate AML into individual files for each audio mod
mkdir $MODPATH/.scripts
while read line; do
  case $line in
    \#*) if [ "$uuid" ]; then
           echo " " >> $MODPATH/.scripts/$uuid.sh
         fi
         uuid=$(echo "$line" | sed "s/#//g");;
    *) echo "$line" >> $MODPATH/.scripts/$uuid.sh;;
  esac
done < $MODPATH/AudioModificationLibrary.sh
rm -f $MODPATH/AudioModificationLibrary.sh
# Generate libs var for faster script running
for i in $MODPATH/.scripts/*; do
  libs="$libs-name \"$(basename $i | sed "s/~.*//g")\" "
done
libs="$(echo $libs | sed "s/\" /\" -o /g")"
sed -i -e "s|<libs>|$libs|g" $MODPATH/service.sh

# Set vars in script
[ -z $SERVICED ] && SERVICED=$NVBASE/service.d
amldir=$NVBASE/aml
for i in amldir; do
  for j in post-fs-data service uninstall; do
    sed -i "s|$i=|$i=$(eval echo \$$i)|g" $MODPATH/$j.sh
  done
done

# Place fallback script in the event idiot user deletes aml module in file explorer
mkdir $SERVICED 2>/dev/null
cp -f $MODPATH/uninstall.sh $SERVICED/aml.sh
chmod 0755 $SERVICED/aml.sh
sed -i -e "3a[ -d \"\$moddir/$MODID\" -a ! -f \"\$moddir/$MODID/disable\" ] && exit 0" -e "s|^moddir=.*|moddir=$NVBASE/modules|g" $SERVICED/aml.sh
echo 'rm -f $0' >> $SERVICED/aml.sh

rm -f $MODPATH/install.zip





