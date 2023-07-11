ui_print " "
ui_print "  Mod detection and patching now happens at boot"
ui_print "  The boot script handles everything now"
ui_print " "
ui_print "  Also note that disabled mods will be ignored!"
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
         uuid=$(echo "$line" | sed "s/#//");;
    *) echo "$line" >> $MODPATH/.scripts/$uuid.sh;;
  esac
done < $MODPATH/AudioModificationLibrary.sh
rm -f $MODPATH/AudioModificationLibrary.sh
# Generate libs var for faster script running
for i in $MODPATH/.scripts/*; do
  libs="$libs-name \"$(basename $i | sed "s/~.*//")\" "
done
libs="$(echo $libs | sed "s/\" /\" -o /g")"
sed -i -e "s|<libs>|$libs|" $MODPATH/service.sh

# Set vars in script
[ -z $SERVICED ] && SERVICED=$NVBASE/service.d
amldir=$NVBASE/aml
for i in API amldir; do
  for j in post-fs-data service uninstall; do
    sed -i "s|$i=|$i=$(eval echo \$$i)|" $MODPATH/$j.sh
  done
done

# Place fallback script in the event idiot user deletes aml module in file explorer
mkdir $SERVICED 2>/dev/null
cp -f $MODPATH/uninstall.sh $SERVICED/aml.sh
chmod 0755 $SERVICED/aml.sh
sed -i -e "3a[ -d \"\$moddir/$MODID\" -a ! -f \"\$moddir/$MODID/disable\" ] && exit 0" -e "s|^moddir=.*|moddir=$NVBASE/modules|" $SERVICED/aml.sh
echo 'rm -f $0' >> $SERVICED/aml.sh

rm -f $MODPATH/install.zip