#!/bin/sh
#bof
spdmerlin_installed(){
	scriptname=spdMerlin
	scriptgrep=' SCRIPT_VERSION='
	if [ "$su" = 1 ]; then
		remoteurl="https://raw.githubusercontent.com/jackyaz/spdMerlin/master/spdmerlin.sh"
		grepcheck=jackyaz
	fi
	script_check
	printf "${GN_BG} j4${NC} %-9s%-21s%${COR}s\\n" "open" "spdMerlin     $localver" " $upd"
	case_j4(){
		/jffs/scripts/spdmerlin
		sleep 2
		show_amtm menu
	}
}
install_spdmerlin(){
	p_e_l
	echo " This installs spdMerlin - Automatic speedtest for AsusWRT Merlin - with graphs"
	echo " on your router."
	echo
	echo " Author: Jack Yaz"
	echo " https://www.snbforums.com/threads/spdmerlin-automated-speedtests-with-graphs.55904/"
	c_d

	c_url "https://raw.githubusercontent.com/jackyaz/spdMerlin/master/spdmerlin.sh" -o "/jffs/scripts/spdmerlin" && chmod 0755 /jffs/scripts/spdmerlin && /jffs/scripts/spdmerlin install
	sleep 2
	if [ -f /jffs/scripts/spdmerlin ]; then
		show_amtm " spdMerlin installed"
	else
		am=;show_amtm " spdMerlin installation failed"
	fi
}
#eof