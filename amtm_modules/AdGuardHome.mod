#!/bin/sh
#bof
AdGuardHome_installed(){
	scriptname=AdGuardHome
	scriptgrep='^AI_VERSION'
	if [ "$su" = 1 ]; then
		remoteurl=https://raw.githubusercontent.com/jumpsmm7/Asuswrt-Merlin-AdGuardHome-Installer/master/installer
		grepcheck=SomeWhereOverTheRainBow
		localAGHver="$(/opt/etc/AdGuardHome/AdGuardHome --version | cut -d" "  -f4-)"
		remoteAGHver=$(c_url https://api.github.com/repos/AdguardTeam/AdGuardHome/releases/latest | grep "tag_name" | head -1 | cut -d \" -f 4)
		updAGH="${E_BG}${NC}$localAGHver"
		AGHext="AGH binary"
		updAGH="${GN_BG}$localAGHver${NC}"
		if [ "$localAGHver" ] && [ "$remoteAGHver" ]; then
			if [ "$localAGHver" != "$remoteAGHver" ]; then
				updAGH="${E_BG}-> $remoteAGHver${NC}"
				[ "$tpu" ] && echo "- $scriptname binary $localAGHver -> $remoteAGHver <br>" >>/tmp/amtm-tpu-check
				suUpd=1
				AGHext="AGH bin"
				echo "AGHbinUpate=\"-> $remoteAGHver\"">>"${add}"/availUpd.txt
				echo "AGHbinVer=\"$localAGHver\"">>"${add}"/availUpd.txt
			else
				localAGHver=
			fi
		else
			updAGH=" ${E_BG}upd err${NC}"
		fi
	fi
	script_check
	if [ -z "$su" -a -z "$tpu" ] && [ "$AdGuardHomeUpate" -o "$AGHbinUpate" ]; then
		localver="$lvtpu"
		upd="${E_BG}$AdGuardHomeUpate${NC}"
		if [ "$AdGuardHomeMD5" != "$(md5sum "$scriptloc" | awk '{print $1}')" ]; then
			sed -i '/^AdGuardHome.*/d' "${add}"/availUpd.txt
			upd="${E_BG}${NC}$lvtpu"
			unset localver AdGuardHomeUpate AdGuardHomeMD5
		fi
		if [ "$AGHbinUpate" ]; then
			localAGHver="$(/opt/etc/AdGuardHome/AdGuardHome --version | cut -d" "  -f4-)"
			if [ "$AGHbinVer" != "$localAGHver" ]; then
				sed -i '/^AGHbin.*/d' "${add}"/availUpd.txt
				unset AGHbinUpate AGHbinVer
			else
				AGHext="AGH bin"
				updAGH="${E_BG}$AGHbinUpate${NC}"
			fi
		fi
	fi
	[ -z "$updcheck" ] && printf "${GN_BG} ag${NC} %-9s%-21s%${COR}s\\n" "open" "AdGuardHome    $localver" " $upd"
	[ "$su" = 1 -a -z "$updcheck" ] || [ "$AGHbinUpate" ] && printf "${GN_BG}   ${NC} %-9s%-21s%${COR}s\\n" "" "$AGHext $localAGHver" " $updAGH"
	case_ag(){
		/opt/etc/AdGuardHome/installer
		sleep 2
		show_amtm menu
	}
}
install_AdGuardHome(){
	p_e_l
	echo " This installs AdGuardHome - Asuswrt-Merlin-AdGuardHome-Installer"
	echo " on your router."
	echo
	echo " Author: SomeWhereOverTheRainBow"
	echo " https://www.snbforums.com/threads/new-release-asuswrt-merlin-adguardhome-installer.76506/#post-733310"
	c_d
	c_url https://raw.githubusercontent.com/jumpsmm7/Asuswrt-Merlin-AdGuardHome-Installer/master/installer && sh installer ; rm installer
	sleep 2
	if [ -f /opt/etc/AdGuardHome/installer ]; then
		show_amtm " AdGuardHome installed"
	else
		am=;show_amtm " AdGuardHome installation failed"
	fi
}
#eof