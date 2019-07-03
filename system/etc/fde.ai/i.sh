#!/system/bin/sh

###FDE.AI v4 | FeraVolt.2019###
if [-d /sbin/.magisk/img/FDE];
then SYSFD = /sbin/.magisk/img/FDE/system;
else SYSFD = /system;fi;
if [ ! -d /sbin/.magisk/img/FDE ];then 
mount -o rw,remount /system;
mount - o rw remount /system;
fi;

chmod 777 $SYSFD /etc/fde.ai;
chmod -R 777 $SYSFD /etc/fde.ai/b/;
sleep 0.5;
A=$(grep -Eo "ro.product.cpu.abi(2)?=.+" /system/build.prop 2>/dev/null|grep -Eo "[^=]*$"|head -n1);
if [ "$A" = "$(echo "$A"|grep "arm64")" ];then 
cp $SYSFD/etc/fde.ai/b/ba64 $SYSFD/etc/fde.ai/busybox;
cp $SYSFD/etc/fde.ai/b/fa64 $SYSFD/etc/fde.ai/f;
echo "64-bit ARM arch detected.";
elif [ "$A" = "$(echo "$A"|grep "armeabi")" ];then 
cp $SYSFD/etc/fde.ai/b/ba32 $SYSFD/etc/fde.ai/busybox;
cp $SYSFD/etc/fde.ai/b/fa32 $SYSFD/etc/fde.ai/f;
echo "32-bit ARM arch detected.";
elif [ "$A" = "$(echo "$A"|grep "x86_64")" ];then 
cp $SYSFD/etc/fde.ai/b/bx64 $SYSFD/etc/fde.ai/busybox;
cp $SYSFD/etc/fde.ai/b/fx64 $SYSFD/etc/fde.ai/f;
echo "64-bit X86 arch detected.";
else 
cp $SYSFD/etc/fde.ai/b/ba32 $SYSFD/etc/fde.ai/busybox;
cp $SYSFD/etc/fde.ai/b/fa32 $SYSFD/etc/fde.ai/f;
echo "Unknown arch. 32-bit ARM variant used.";
fi;
sleep 1;
chmod 777 $SYSFD/etc/fde.ai/b/*;
B=/system/etc/fde.ai/busybox;

if [ -e /sys/power/wake_lock ]; then 
$B echo "fde">/sys/power/wake_lock;
fi;

if [ ! -d /sbin/.magisk/img/FDE ];then 
$B mount -o remount,rw /system;
$B mount -o remount,rw /vendor;
mount -o remount,rw /system;
mount -o remount rw /system;
mount -o remount,rw /vendor;

if [ -e /system/bin/tiny_mkswap ];then 
$B mv -f /system/bin/tiny_mkswap /system/bin/tiny_mkswap_bak;
$B mv -f /system/bin/tiny_swapon /system/bin/tiny_swapon_bak;
fi;

if [ -e /vendor/bin/tiny_mkswap ];then 
$B mv -f /vendor/bin/tiny_mkswap /vendor/bin/tiny_mkswap_bak;
$B mv -f /vendor/bin/tiny_swapon /vendor/bin/tiny_swapon_bak;
fi;

if [ -e /system/xbin/zram.sh ];then 
$B mv -f /system/xbin/zram.sh /system/xbin/zram_sh_bak;
fi;
fi;
$B mount -o remount,rw /data;
mount -o remount,rw /data;
$B rm -Rf $SYSFD/etc/fde.ai/b;
$B cp -f /fstab.* $SYSFD/etc/;
$B cp -f /vendor/etc/fstab.* $SYSFD/etc/;
$B mv -f $SYSFD/etc/fstab.* $SYSFD/etc/fstab;
$B chmod 664 $SYSFD/etc/fstab;
$B rm -f /data/system/batterystats.bin;
$B rm -f /data/system/batterystats-checkin.bin;
$B rm -f /data/local.prop;$B rm -f /data/fprop;
$B rm -f /data/misc/mtkgps.dat;
$B rm -f /data/misc/epo.dat;
$B sleep 0.5;
$B touch /data/local.prop;
$B touch /data/fprop;
$B touch /data/F;
$B chmod 644 /data/local.prop;
$B chmod 777 /data/fprop;
$B chmod 777 /data/F;
$B echo "1">/data/F;
S=$($B grep "ro.build.version.sdk" /system/build.prop|$B cut -d "=" -f 2);
CORE=$($B grep -c 'processor' /proc/cpuinfo);
C=$((CORE-1));
if [ "$C" = "0" ];then 
C=1;
fi;
PPP=$($B df -P|$B grep /data|$B head -n 1|$B awk '{ print $2 }');
ZZZ=$((PPP/1024/1024));
$B sleep 0.5;
{ 
$B echo " ";
$B echo "### FDE.AI v4 | FeraVolt. 2019 ###";
$B echo "fde_ver=4.10";
$B echo "ro.HOME_APP_ADJ=1";
$B echo "persist.radio.ramdump=0";
$B echo "pm.sleep_mode=1";
$B echo "persist.wpa_supplicant.debug=false";
$B echo "dalvik.vm.checkjni=false";
$B echo "dalvik.vm.check-dex-sum=false";
$B echo "dalvik.vm.debug.alloc=0";
$B echo "dalvik.vm.deadlock-predict=off";
$B echo "dalvik.vm.verify-bytecode=false";
$B echo "libc.debug.malloc=0";
$B echo "debug.atrace.tags.enableflags=0";
$B echo "ro.media.enc.jpeg.quality=100";
$B echo "vidc.debug.level=0";
$B echo "debug.mdpcomp.logs=0";
$B echo "logd.logpersistd.enable=false";
$B echo "ro.kernel.android.checkjni=0";
$B echo "touch.pressure.scale=0.5";
$B echo "ro.config.nocheckin=1";
$B echo "ro.kernel.checkjni=0";
$B echo "debug.sqlite.journalmode=WAL";
$B echo "debug.sqlite.syncmode=1";
$B echo "profiler.launch=false";
$B echo "profiler.force_disable_err_rpt=1";
$B echo "profiler.force_disable_ulog=1";
$B echo "profiler.debugmonitor=false";
$B echo "profiler.hung.dumpdobugreport=false";
$B echo "debugtool.anrhistory=0";
$B echo "video.accelerate.hw=1";
$B echo "trustkernel.log.state=disable";
}>>/data/local.prop;
if [ "$S" -ge "21" ];then 
{ $B echo "dalvik.vm.dex2oat-threads=$C";
 $B echo "dalvik.vm.bg-dex2oat-threads=$C";
 $B echo "dalvik.vm.boot-dex2oat-threads=$C";
 if [ "$ZZZ" -ge "6" ];then 
 $B echo "dalvik.vm.dex2oat-filter=speed";
 fi;
 $B echo "dalvik.vm.dex2oat-minidebuginfo=false";
 $B echo "persist.dalvik.vm.dex2oat-threads=$C";
 $B echo "ro.config.max_starting_bg=$C";
 $B echo "ro.sys.fw.dex2oat_thread_count=$C";
 $B echo "sys.sysctl.tcp_def_init_rwnd=60";
 $B echo "sys.display-size=3840x2160";}>>/data/local.prop;
fi;
if [ "$S" -ge "24" ];then 
{ 
 if [ "$ZZZ" -ge "6" ];then 
 $B echo "pm.dexopt.bg-dexopt=speed-profile";
 $B echo "pm.dexopt.shared=speed";
 fi;
 $B echo "dalvik.vm.usejit=true";
 $B echo "dalvik.vm.usejitprofiles=true";
 $B echo "vidc.debug.perf.mode=2";
 $B echo "af.fast_track_multiplier=1";
 $B echo "mm.enable.smoothstreaming=true";
 $B echo "ro.boot.verifiedbootstate=green";
 $B echo "ro.boot.flash.locked=1";
 $B echo "ro.boot.veritymode=enforcing";
 $B echo "ro.boot.warranty_bit=0";
 $B echo "ro.warranty_bit=0";
 $B echo "ro.debuggable=0";
 $B echo "ro.secure=1";
 $B echo "selinux.reload_policy=1";
 $B echo "ro.audio.flinger_standbytime_ms=300";
 $B echo "ro.config.hw_quickpoweron=true";
 }>>/data/local.prop;
fi;
if [ "$SDK" -le "20" ];then 
{ 
  $B echo "media.stagefright.enable-http=false";
  $B echo "media.stagefright.enable-qcp=false";
  $B echo "media.stagefright.enable-fma2dp=false";
  $B echo "ro.ril.disable.power.collapse=0";
  $B echo "ro.telephony.call_ring.delay=0";
  $B echo "ro.ril.fast.dormancy.rule=0";
  $B echo "ro.ril.gprsclass=12";
  $B echo "ro.ril.enable.a53=1";
  $B echo "ro.ril.hep=1";
  $B echo "MIN_HIDDEN_APPS=false";
  $B echo "MIN_RECENT_TASKS=false";
  $B echo "APP_SWITCH_DELAY_TIME=false";
  $B echo "windowsmgr.max_events_per_sec=120";
  $B echo "ro.max.fling_velocity=18000";
  $B echo "ro.min.fling_velocity=900";
}>>/data/local.prop;
fi;
if [ "$S" -le "22" ];then 
{ 
  $B echo "persist.sys.ui.hw=1";
  $B echo "persist.sys.use_dithering=0";
  $B echo "debug.composition.type=gpu";
  $B echo "wifi.supplicant_scan_interval=180";
  $B echo "dev.pm.dyn_samplingrate=1";
  $B echo "debug.sf.hw=1";
  $B echo "debug.egl.hw=1";
  $B echo "debug.gr.swapinterval=1";
  $B echo "debug.egl.swapinterval=-60";
  $B echo "debug.gr.numframebuffers=3";
  $B echo "ro.config.disable.hw_accel=false";
  $B echo "hwui.render_dirty_regions=false";
  $B echo "debug.hwui.render_dirty_regions=false";
  $B echo "ro.floatingtouch.available=1";
 }>>/data/local.prop;
if [ ! -d /sbin/.magisk/img/FDE ];then 
$B cp -f /system/lib/egl/egl.cfg /system/lib/egl/egl.cfg_bak;
$B sed -i '/0 0 android/d' /system/lib/egl/egl.cfg;
$B cp -f /system/lib/egl/libGLES_android.so /system/lib/egl/bak.bak_so;
$B rm -f /system/lib/egl/libGLES_android.so;
fi;
fi;
$B echo " ">>/data/local.prop;
$B sleep 9;
pm install -r /system/etc/fde.ai/module.png;
$B chmod 644 /data/local.prop;
$B rm -f $SYSFD/etc/fde.ai/module.png;
$B rm -f /data/local/tmp/*.apk;
$B cat /data/local.prop|$B sed 's/=/ /g'>/data/fprop;
if [ -d /sbin/.magisk/img/FDE ];then 
$B cp /data/local.prop /sbin/.magisk/img/FDE/system.prop;
$B rm -f /data/local.prop;
fi;
if [ -e /sys/power/wake_unlock ];then 
$B echo "fde">/sys/power/wake_unlock;
fi;
exit;