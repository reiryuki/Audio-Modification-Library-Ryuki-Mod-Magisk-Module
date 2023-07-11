#!/system/bin/sh
moddir=$(dirname ${0%/*})
amldir=
if [ -s $amldir/modlist ]; then
  while read mod; do
    [ -d "$moddir/$mod" ] || continue
    for file in $(find $amldir/$mod -type f 2>/dev/null | sed "s|$amldir/||"); do
      [ -f "$moddir/$file" ] || mkdir -p "$(dirname "$moddir/$file")" && cp -af $amldir/$file $moddir/$file
    done
  done < $amldir/modlist
fi
rm -rf $amldir
[ -f "$moddir/acdb/post-fs-data.sh.bak" ] && mv -f $moddir/acdb/post-fs-data.sh.bak $moddir/acdb/post-fs-data.sh



