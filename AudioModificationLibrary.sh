#libam3daudioenhancement.so~6723dd80-f0b7-11e0-98a2-0002a5d5c51b
patch_cfgs am3daudioenhancement 6723dd80-f0b7-11e0-98a2-0002a5d5c51b am3daudioenhancement $libfile
#libv4a_fx.so~41d3c987-e6cf-11e3-a88a-11aba5d5c51b
patch_cfgs v4a_standard_fx 41d3c987-e6cf-11e3-a88a-11aba5d5c51b v4a_fx $libfile
#libv4a_fx_ics.so~41d3c987-e6cf-11e3-a88a-11aba5d5c51b
patch_cfgs v4a_standard_fx 41d3c987-e6cf-11e3-a88a-11aba5d5c51b v4a_fx $libfile
#libv4a_xhifi_ics.so~d92c3a90-3e26-11e2-a25f-0800200c9a66
patch_cfgs v4a_standard_xhifi d92c3a90-3e26-11e2-a25f-0800200c9a66 v4a_xhifi $libfile
#libhwdax.so~9d4921da-8225-4f29-aefa-6e6f69726861
patch_cfgs -pl dax 9d4921da-8225-4f29-aefa-6e6f69726861 dax_sw 6ab06da4-c516-4611-8166-6168726e6f69 $(dirname $libfile)/libswdax.so dax_hw a0c30891-8246-4aef-b8ad-696f6e726861 $libfile
#libswdax.so~9d4921da-8225-4f29-aefa-6e6f69726861
patch_cfgs dax 9d4921da-8225-4f29-aefa-6e6f69726861 dax $libfile
#libswdap.so~9d4921da-8225-4f29-aefa-39537a04bcaa
patch_cfgs dap 9d4921da-8225-4f29-aefa-39537a04bcaa dap $libfile
#libhwdap.so~a0c30891-8246-4aef-b8ad-d53e26da0253
patch_cfgs -pl dap 9d4921da-8225-4f29-aefa-6e6f69726861 dap_sw 6ab06da4-c516-4611-8166-452799218539 $(dirname $libfile)/libswdap.so dap_hw a0c30891-8246-4aef-b8ad-d53e26da0253 $libfile
#libdseffect.so~9d4921da-8225-4f29-aefa-39537a04bcaa
patch_cfgs dsplus 9d4921da-8225-4f29-aefa-39537a04bcaa ds $libfile
#libswvlldp.so~3783c334-d3a0-4d13-874f-0032e5fb80e2
patch_cfgs vlldp 3783c334-d3a0-4d13-874f-0032e5fb80e2 vlldp $libfile
patch_cfgs -ole music atmos 9d4921da-8225-4f29-aefa-aacb40a73593 atmos $(dirname $libfile)/libatmos.so
#libicepower.so~f1c02420-777f-11e3-981f-0800200c9a66
patch_cfgs -l icepower $libfile
patch_cfgs -e icepower_algo f1c02420-777f-11e3-981f-0800200c9a66 icepower
patch_cfgs -e icepower_eq 50dbef80-4ad4-11e3-8f96-0800200c9a66 icepower
patch_cfgs -e icepower_test e5456320-5391-11e3-8f96-0800200c9a66 icepower
patch_cfgs -e icepower_load bf51a790-512b-11e3-8f96-0800200c9a66 icepower
patch_cfgs -e icepower_null 63509430-52aa-11e3-8f96-0800200c9a66 icepower
#libarkamys.so~17852d50-161e-11e2-892e-0800200c9a66
patch_cfgs -ole music Arkamysfx 17852d50-161e-11e2-892e-0800200c9a66 arkamys $libfile
#libdirac.so~4c6383e0-ff7d-11e0-b6d8-0002a5d5c51b
patch_cfgs dirac 4c6383e0-ff7d-11e0-b6d8-0002a5d5c51b dirac $libfile
patch_cfgs -e dirac_controller b437f4de-da28-449b-9673-667f8b9643fe dirac
patch_cfgs -e dirac_music b437f4de-da28-449b-9673-667f8b964304 dirac
#libdirac.so~e069d9e0-8329-11df-9168-0002a5d5c51b
patch_cfgs -ole music dirac e069d9e0-8329-11df-9168-0002a5d5c51b dirac $libfile
#libjamesdsp.so~f27317f4-c984-4de6-9a90-545759495bf2
patch_cfgs jamesdsp f27317f4-c984-4de6-9a90-545759495bf2 jdsp $libfile
#libmaxxeffect-cembedded.so~ae12da60-99ac-11df-b456-0002a5d5c51b
patch_cfgs -ole music maxxaudio3 ae12da60-99ac-11df-b456-0002a5d5c51b maxxaudio3 $libfile
#libbassboostMz.so~850b6319-bf66-4f93-bec0-dc6964367786
patch_cfgs bassboostMz 850b6319-bf66-4f93-bec0-dc6964367786 bassboostMz $libfile
patch_cfgs virtualizerMz 0e9779c9-4e8f-494d-b2b1-b4ad4e37c54c virtualizerMz $(dirname $libfile)/libvirtualizerMz.so
patch_cfgs livemusicMz 0bbc89fe-52dc-4c40-8211-cae4da538b50 livemusicMz $(dirname $libfile)/liblivemusicMz.so
patch_cfgs equalizerMz 9626da93-9c71-4bb2-8e23-9fc707fb9703 equalizerMz $(dirname $libfile)/ibequalizerMz.so
#libsonysweffect.so~50786e95-da76-4557-976b-7981bdf6feb9
patch_cfgs -qle mic,camcorder ZNR b8a031e0-6bbf-11e5-b9ef-0002a5d5c51b znrwrapper $(dirname $libfile)/libznrwrapper.so
patch_cfgs -pl sonyeffect af8da7e0-2ca1-11e3-b71d-0002a5d5c51b sonyeffect_sw 50786e95-da76-4557-976b-7981bdf6feb9 $libfile sonyeffect_hw f9ed8ae0-1b9c-11e4-8900-0002a5d5c51b $(dirname $libfile)/libsonypostprocbundle.so
#libatmos.so~74697567-7261-6564-6864-65726f206678
patch_cfgs dolbyatmos 74697567-7261-6564-6864-65726f206678 dolbyatmos $libfile
osp_detect "alarm notification ring"
#libswdap_ds1se.so~74697567-7261-6564-6864-65726f206678
patch_cfgs dolbyatmos 74697567-7261-6564-6864-65726f206678 dolbyatmos $libfile
osp_detect "alarm notification ring"
#libdtsaudio.so~146edfc0-7ed2-11e4-80eb-0002a5d5c51b
patch_cfgs -ole music dtsaudio 146edfc0-7ed2-11e4-80eb-0002a5d5c51b dtsaudio $libfile
#libv4a_re.so~90380da3-8536-4744-a6a3-5731970e640f
patch_cfgs v4a_re 90380da3-8536-4744-a6a3-5731970e640f v4a_re $libfile
#end
