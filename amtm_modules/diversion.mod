#!/bin/sh
#bof
diversion_installed(){
	scriptname=Diversion
	localVother="$(grep ^VERSION "$scriptloc" | sed -e 's/VERSION=//')"

	if [ "$(v_c $localVother)" -ge "$(v_c 5.0)" ]; then
		if [ "$su" = 1 ]; then
			case "$release" in
				*XX*) 	remoteurl="http://diversion.test/diversion_adblocking/diversion";;
				*) 		remoteurl="https://diversion.ch/diversion_adblocking/diversion";;
			esac
			remoteVother="$(c_url "$remoteurl" | grep ^VERSION | sed -e 's/VERSION=//')"
			grepcheck=thelonelycoder
		fi
		script_check
		if [ -z "$su" -a -z "$tpu" ] && [ "$DiversionUpate" ]; then
			localver="$lvtpu"
			upd="${E_BG}$DiversionUpate${NC}"
			if [ "$DiversionMD5" != "$(md5sum "$scriptloc" | awk '{print $1}')" ]; then
				[ -f "${add}"/availUpd.txt ] && sed -i '/^Diversion.*/d' "${add}"/availUpd.txt
				upd="${E_BG}${NC}$lvtpu"
				unset localver DiversionUpate DiversionMD5
			fi
		fi
	else
		localVother=
		if [ -s "$divconf" ]; then
			divver="$(grep "thisVERSION=" "$divconf" | sed -e 's/thisVERSION=//')"
			divMver="$(grep "thisM_VERSION=" "$divconf" | sed -e 's/thisM_VERSION=//')"
			[ "$divMver" ] && divver="${divver}.$divMver" || divver=$divver
		fi
		localver="$divver"
		upd="${E_BG}${NC}$localver"
		if [ "$su" = 1 ]; then
			case "$release" in
				*XX*) 	remoteurl="http://diversion.test/diversion";;
				*) 		remoteurl="https://diversion.ch/diversion";;
			esac
			aUpd=
			if c_url "$remoteurl/diversion.info" | grep -q "^S_VERSION=\|^S_M_VERSION="; then
				remotever="$(c_url "$remoteurl/diversion.info" | grep "^S_VERSION=\|^S_M_VERSION=" | sed -e 's/.*_VERSION=//')"
				S_VERSION=$(echo $remotever | awk '{print $1}')
				S_M_VERSION=$(echo $remotever | awk '{print $2}')
				localmd5="$(md5sum "$scriptloc" | awk '{print $1}')"
				[ "$S_M_VERSION" ] && remotever="${S_VERSION}.$S_M_VERSION" || remotever="$S_VERSION"
				upd="${GN_BG}$divver${NC}"
				webUiOn=no
				if [ -d /www/user/diversion ] && [ -f /opt/share/diversion/.conf/webui-vars.js ]; then
					. /opt/share/diversion/file/helper.div
					webUiOn=yes
				fi

				if [ "$localver" != "$remotever" ]; then
					localver="$divver"
					upd="${E_BG}-> $remotever${NC}"
					aUpd="-> $remotever"
					[ "$updcheck" ] && echo "- Diversion $localver $aUpd" >>/tmp/amtm-tpu-check
					suUpd=1
					if [ "$webUiOn" = yes ]; then
						webui_set Diversion_update $(echo $remotever | sed 's/v//')
						webui_set Diversion_S_VERSION $S_VERSION
					fi
				else
					remotemd5="$(c_url "$remoteurl/$S_VERSION/diversion" | md5sum | awk '{print $1}')"
					if [ "$localmd5" != "$remotemd5" ]; then
						localver="$divver"
						upd="${E_BG}-> MD5 upd${NC}"
						aUpd="-> MD5 upd"
						[ "$updcheck" ] && echo "- Diversion $localver, MD5 hash change detected" >>/tmp/amtm-tpu-check
						suUpd=1
						[ "$webUiOn" = yes ] && webui_set Diversion_update min-upd
					else
						localver=
						if [ "$webUiOn" = yes ] && [ "$(webui_get Diversion_update)" ]; then
							webui_del Diversion_update
							webui_del Diversion_S_VERSION
						fi
					fi
				fi
				if [ "$aUpd" ]; then
					echo "DiversionUpate=\"$aUpd\"">>"${add}"/availUpd.txt
					echo "DiversionMD5=\"$localmd5\"">>"${add}"/availUpd.txt
				fi
			else
				upd=" ${E_BG}upd err${NC}"
				updErr=1
				a_m " ! Diversion: ${R}$(echo $remoteurl | awk -F[/:] '{print $4}')${NC} unreachable"
			fi
		elif [ "$DiversionUpate" ]; then
			upd="${E_BG}$DiversionUpate${NC}"
			if [ "$DiversionMD5" != "$(md5sum "$scriptloc" | awk '{print $1}')" ]; then
				[ -f "${add}"/availUpd.txt ] && sed -i '/^Diversion.*/d' "${add}"/availUpd.txt
				upd="${E_BG}${NC}$localver"
				unset localver DiversionUpate DiversionMD5
			fi
		else
			localver=
		fi
	fi

	[ -z "$updcheck" -a -z "$ss" ] && printf "${GN_BG} 1 ${NC} %-9s%-21s%${COR}s\\n" "open" "Diversion     $localver" " $upd"
	case_1(){
		trap trap_ctrl 2
		trap_ctrl(){
			sleep 2
			exec "$0"
		}
		/opt/bin/diversion
		trap - 2
		sleep 2
		show_amtm menu
	}
}
install_diversion(){
	p_e_l
	printf " This installs Diversion - the Router Adblocker\\n on your router.\\n\\n"
	printf " Author: thelonelycoder\\n snbforums.com/forums/asuswrt-merlin-addons.60/?prefix_id=10&starter_id=25480\\n"
	c_d
	case "$release" in
		*XX*) 	remoteurl="http://diversion.test/install";;
		*) 		remoteurl="https://diversion.ch/install";;
	esac
	c_url -Os "$remoteurl" && sh install
	sleep 2
	if [ -f /opt/bin/diversion ]; then
		show_amtm " Diversion installed"
	else
		am=;show_amtm " Diversion installation failed"
	fi
}
#eof
