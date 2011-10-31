#!/bin/bash
path_script="readlink -f \"$0\""
path_autostart_script="/etc/xdg/lxsession/LXDE/autostart"
tmp_file="$dir_script/stage.tmp"
lxdm_conf_file="/etc/lxdm/lxdm.conf"
max_stage=10
err=0

#Check for 64bit
if [ "$(uname -m)" != "x86_64" ]; then
    err="Error: This is NOT an x86_64 Linux"
fi

#Check for root user
WHOAMI=`/usr/bin/whoami`
if [ "$WHOAMI" != "root" ] ; then
    err="Error: You must be the root user to run installer"
fi

# Check for zenity
if [ ! -f /usr/bin/zenity ] ; then
   echo -e "Installer requires \"zenity\" to provide its graphical user interface.\n"
   echo 'To install zenity, the "gnome-utils" package and its dependencies'
   echo -e "will be installed.\n"
   echo -n "Continue with zenity installation? (Y/n) "
   read YN
   # Default response is "Y"
   : ${YN:=Y}
   case $YN in
      [yY]|[yY][eE][sS]) lxterminal -e `yum -y install gnome-utils || exit 1` ;;
      *) exit 0 ;; 
   esac
fi

#User
username="bm"


#Stage
if [ "$err" == 0 ] ; then
    if [ -e "$tmp_file" ] ; then
	string_stage=`cat $tmp_file`
	if [ -z "$string_stage" ] ;then
		    stage="1"
		    echo "1" > $tmp_file
		else
		    stage="$string_stage"
	fi
    else 
	touch $tmp_file
	stage="1"
	echo "1" >> $tmp_file
    fi
fi

#Body
if [ "$err" -eq 0 ] ; then
	case "$stage" in
	
	1)
	    echo "10" ; sleep 1
	    echo "# Устанавливаю sleep в 0.5c и tmpfs"; sleep 1
	    sed -i~ '/usleep/!s/sleep 1/sleep 0.5/g' /etc/init.d/*
            sed -i~ '/usleep/!s/sleep 2/sleep 0.5/g' /etc/init.d/*
            sed -i~ '/usleep/!s/sleep 3/sleep 0.5/g' /etc/init.d/*
            sed -i~ '/usleep/!s/sleep 4/sleep 0.5/g' /etc/init.d/*
            sed -i~ '/usleep/!s/sleep 5/sleep 0.5/g' /etc/init.d/*
	    echo "tmpfs		/tmp		tmpfs defaults 0 0" >> /etc/fstab
	    echo "tmpfs		/var/tmp	tmpfs defaults 0 0" >> /etc/fstab
            echo "13"
            echo "# Устанавливаем initng"; sleep 1
            yum -y install initng || exit 1
            echo "16" ; sleep 1
            #TODO autologin in base 
            echo "# Set autologin on" ; sleep 1
            sed -i '/autologin/d' /etc/lxdm/lxdm.conf
            echo "autologin=$username" >> /etc/lxdm/lxdm.conf
	    echo "2" > $tmp_file
	    sed -i '/xscreenserver/d' $path_autostart_script
	    echo "@$patch_script" >> $path_autostart_script
	    reboot
	    ;;
	2)
	    echo "20"
	    echo "# Kernel updating"
	    yum -y update kernel*
	    echo "3" > $tmp_file
	    reboot
	    ;;
	3)
	    echo "30" ; sleep 1
	    echo "# Nvidia driver install" ; sleep 1
	    rpm -Uhv http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
	    rpm -Uhv http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm
	    yum -y install kmod-nvidia xorg-x11-drv-nvidia-libs|| exit 1
	    echo "4" > $tmp_file
	    reboot
	    ;;
	4)
	    echo "40"
            echo "# Nvidia driver postinstall"
            mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img
            dracut /boot/initramfs-$(uname -r).img $(uname -r)
	    echo "# Boot optimization"
	    cd /lib/systemd/systemd
	    for i in fedora-* plymouth-*; do sudo ln -s /dev/null /etc/systemd/system/$i;done
	    for i in abrt-ccpp abrt-oops cups mdmonitor netfs nfslock pcscd portreserve rpcbind rpcgssd rpcidmapd sendmail smolt ip6tables iptables sandbox selinux; do sudo chkconfig $i off;done
	    yum -y remove $(rpm -qf --qf '%{name}\n' /etc/init.d/auditd /lib/systemd/system/{abrtd.service,mcelog.service})
	    cd /lib/systemd/systemd
	    for i in *readahead*; do systemctl disable $i;done
	    cd /lib/systemd/system 
	    for i in *readahead*; do systemctl enable $i;done
            echo "5" > $tmp_file
	    reboot
            ;;
        5)
            echo "50"
            echo "Removing unneeded packets"
            yum -y remove xorg-x11-drv-elographics
            export PKG_CONFIG_PATH=/usr/lib/pkgconfig
            yum -y install xorg-x11-proto-devel git gcc autoconf libtool automake libXi-devel gcc-c++ svn zlib-devel plymouth  plymouth-theme-scripts plymouth-plugin-script mesa-libGl-devel libmikmod-devel libvorbis-devel sqlite-devel pcre-devel libpng-dev libjpeg-turbo-devel freetype-devel fontconfig-devel lua tolua++-devel tolua++ alsa-lib-devel php
            echo "#Setting persist eGalax calibration"
            echo "Section \"InputClass\"" > /etc/X11/xorg.conf.d/99-calibration.conf
            echo "    Identifier      \"calibration\"" >> /etc/X11/xorg.conf.d/99-calibration.conf
            echo "    MatchProduct    \"eGalax Inc.\"" >> /etc/X11/xorg.conf.d/99-calibration.conf
            echo "    Option  \"Calibration\"   \"1747 250 460 1816\"" >> /etc/X11/xorg.conf.d/99-calibration.conf
            echo "    Option  \"SwapAxes\"      \"1\"" >> /etc/X11/xorg.conf.d/99-calibration.conf
            echo "EndSection" >> /etc/X11/xorg.conf.d/99-calibration.conf
            echo "#Building clanlib"
            mkdir clanlib && cd clanlib && svn co svn://esoteric.clanlib.org/ClanLib/Development/ClanLib-2.3 && cd ClanLib-2.3/ && ./autogen.sh && ./configure --prefix=/usr --enable-clanDisplay --enable-clanGL  --enable-clanGL1 --enable-clanSound --enable-clanDatabase --enable-clanSqlite --enable-clanRegExp --enable-clanNetwork --enable-clanGUI --enable-clanMikMod --enable-clanVorbis --libdir=/usr/lib64 && make -j3 && make install clanlib
            yum -y clean all
            echo "6" > $tmp_file
            reboot
            ;;
        
        6)
            echo "60"
            modprobe nvidiafb
            echo "#Modyfing grub.conf"
            rm /tmp/grub.conf 2> /dev/null
            while read line
            do
              echo ${line/root=/video=nvidiafb vga=0x031B root=} >> /tmp/grub.conf
            done < /boot/grub/grub.conf
            mv -f /tmp/grub.conf /boot/grub/grub.conf
            echo "#Checking blacklists"
            cat /etc/modprobe.d/blacklist.conf | grep nvidi -v > /tmp/blacklist.conf
            mv -f /tmp/blacklist.conf /etc/modprobe.d/blacklist.conf
            cat /etc/modprobe.d/blacklist-nouveau.conf > /tmp/blacklist-nouveau.conf 2> /dev/null
            mv -f /tmp/blacklist-nouveau.conf /etc/modprobe.d/blacklist-nouveau.conf
            echo "#Installing opessh freenx"
            yum -y install openssh-server 
            yum -y install freenx
            nxsetup --install --auto
            ;;


        #TODO balance theme
        # blacklist snd_hda_intel
        # alsa-lib-devel установить
        #
        # для кланлиба ./configure --prefix=/usr --libdir=/usr/lib64 --disable-static
        # yum install openssh-server 
        # yum install freenx
        # nxsetup --install --auto
	*)
	    echo "0";
	    echo "# Stage not found";
	    ;;
    esac
    zenity --progress --auto-close --text="" --title="Допилка системы(stage $stage - $max_stage)" --percentage=$percentage
    
    if [ "$?" = -1 ]; then 
	zenity --error --text="Cancel"
    fi
fi

if [ "$err" != 0  ]
then 
    zenity --error --text="$err"
    exit 0
else 
    zenity --info --text="Complete!"
    exit 0
fi
