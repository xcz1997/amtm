## amtm - the SNBForum Asuswrt-Merlin Terminal Menu

A shortcut manager for popular scripts for wireless routers running [Asuswrt-Merlin](https://github.com/RMerl) firmware.

Discuss and read more on the SmallNetBuilders Forum: [amtm - the SNBForum Asuswrt-Merlin Terminal Menu](https://www.snbforums.com/threads/amtm-the-snbforums-asuswrt-merlin-terminal-menu.42415/)

### How to install on Asuswrt-Merlin
Enter this into your favorite SSH terminal:

```Shell
/usr/sbin/curl -Os https://raw.githubusercontent.com/decoderman/amtm/master/amtm && sh amtm
```

[![amtm v2.4](https://i.imgur.com/LcbQxrP.png "amtm v2.4")](https://i.imgur.com/LcbQxrP.png "amtm v2.4")

### Supported scripts

[Diversion](https://www.snbforums.com/threads/diversion-the-router-adblocker.48538/) - maintained by thelonelycoder<br/>
[Skynet](https://www.snbforums.com/threads/release-skynet-router-firewall-security-enhancements.16798/) - maintained by Adamm<br/>
[Stubby-Installer](https://www.snbforums.com/threads/stubby-installer-asuswrt-merlin.49469/) - maintained by Xentrk and Adamm (deprecated)<br/>
[YazFi](https://www.snbforums.com/threads/yazfi-enhanced-asuswrt-merlin-guest-wifi-inc-ssid-vpn-client.45924/) - maintained by Jack Yaz<br/>
[scribe](https://www.snbforums.com/threads/scribe-syslog-ng-and-logrotate-installer.55853/) - maintained by cmkelley<br/>

[connmon](https://www.snbforums.com/threads/connmon-internet-connection-monitoring.56163/) - maintained by Jack Yaz<br/>
[ntpMerlin](https://www.snbforums.com/threads/ntpmerlin-installer-for-kvic-ntp-daemon.55756/) - maintained by Jack Yaz<br/>
[scMerlin](https://www.snbforums.com/threads/scmerlin-service-and-script-control-menu-for-asuswrt-merlin.56277/) - maintained by Jack Yaz<br/>
[spdMerlin](https://www.snbforums.com/threads/spdmerlin-automated-speedtests-with-graphs.55904/) - maintained by Jack Yaz<br/>
[uiDivStats](https://www.snbforums.com/threads/beta-uidivstats-webui-for-diversion-statistics.56393/) - maintained by Jack Yaz<br/>

[DNSCrypt](https://www.snbforums.com/threads/release-dnscrypt-installer-for-asuswrt.36071/) - maintained by bigeyes0x0 (deprecated)<br/>
[Entware](https://github.com/Entware/entware) - maintained by zyxmon & ryzhovau<br/>
[Pixelserv-tls](https://www.snbforums.com/threads/pixelserv-a-better-one-pixel-webserver-for-adblock.26114/) - maintained by kvic (beta support suspended)<br/>

[USB Disk Check at Boot or Hot Plug (improved version)](https://github.com/RMerl/asuswrt-merlin/wiki/USB-Disk-Check-at-Boot-or-Hot-Plug-(improved-version)) - maintained by ColinTaylor, latenitetech, thelonelycoder<br/>
[Format Disk](https://www.snbforums.com/threads/amtm-the-snbforum-asuswrt-merlin-terminal-menu.42415/) - maintained by thelonelycoder and ColinTaylor. Now supports creation of up to three partitions.<br/>

### Additional features

Reboot scheduler via cron job - maintained by thelonelycoder<br/>
Swap file creation and management - maintained by thelonelycoder<br/>
amtm themes - maintained by thelonelycoder<br/>

### How to start amtm after installation
Enter this into your SSH terminal:

```Shell
/jffs/scripts/amtm
```

If Entware is installed on the router, start amtm with this command, [Diversion](https://diversion.ch/) installs Entware by default, amtm has an option to do so.

```Shell
amtm
```
