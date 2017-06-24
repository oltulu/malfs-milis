#!/bin/bash
# lfs dizini oluşturup ortama girdikten sonra bu betiği çalıştırabilirsiniz,bütün ortam içi işlemler yapılacaktır.
masaustu="mate"
mps -GG && mps -G
mps kur linux-firmware
mps kur kernel
mps kur dracut
mps kur xorg
mps -kuruld /root/talimatname/temel-ek/derleme.sira
mps kur $masaustu
# girisci kurulum
mps kur lxdm
mps -kurul /root/ayarlar/gerekli_programlar_$masaustu
cp /root/ayarlar/.xinitrc.$masaustu /root/.xinitrc
cp -r /root/ayarlar/$masaustu/.config /root/
cp /root/ayarlar/network /etc/sysconfig/
cd /var/lib/pkg/DB
grep -rli '/mnt/lfs' * | xargs -i@ sed -i 's/\/mnt\/lfs\///g' @
cd /root/
if [ ! -f /usr/bin/dracut ];then
	tamir_dracut
fi
./lfs-mekanizma -bo
rm -r /depo/paketler/*
mv /var/lib/pkg/tarihce/temel-pkvt.tar.lz /var/lib/pkg/tarihce/temel2-pkvt.tar.lz
rm -r /tmp/*
mps -tro
export LC_ALL="tr_TR.UTF-8"
export LANG="tr_TR.UTF-8"
xdg-user-dirs-update
if [ -f /usr/bin/slim ];then
	cp -f /root/ayarlar/.xinitrc.slim /root/.xinitrc
fi
cp ayarlar/kurulum.desktop /root/Desktop/
cp ayarlar/kurulum.desktop /root/Masaüstü/
tamir_touchpad
tamir_masaustu