# Zaram firmware
Voor het gebruik met KPN is een specifieke firmware-upgrade vereist. Dit betreft een officiële firmware die speciaal is ontwikkeld voor KPN NL. Hoewel deze firmware-upgrade ook werkt op het Delta-netwerk, is dit niet strikt noodzakelijk. Het flashen van de firmware kan volledig worden uitgevoerd op de UDM Pro (SE/Max) zelf, of via een Unifi-switch met een SFP+ poort in combinatie met de UDM Pro (SE/Max).

De firmware dient men via eigen kanalen te bemachtigen. Deze kan momenteel niet worden voorzien via dit kanaal. 
De KPN NL versie betreft `ZR00_V090.08`

## Benodigdheden voor flashen via UDM:
   - SSH toegang
   - Desktop/Laptop met bekabelde verbinding (MacOS of Windows is toegestaan)
   - Vrij SFP+ LAN poort geconfigureerd op subnet 192.168.200.x `ETH9 WAN is niet afdoende voor flashen (voor sommige HW revisions)`
   - TFTP server op Desktop/Laptop `MacOS = trivial.app` - `Windows = Solarwinds TFTP server`
   - Subnet `192.168.200.x` op de UDM Pro (SE/Max). Gebruik enkel static IP's.
   - SFP Address: `192.168.200.1`. Dit is al ingesteld
   - Client Address: `192.168.200.2` Handmatig instellen

## SFP Upgrade Instructie

Om je Zaram SFP+ te upgraden, volg de volgende stappen:

**Login Credentials**:
   - Username: `admin`
   - Password: `zrmt123!@#`

## Gedetailleerde stappen

```bash
/dev/pty1000000000 login: admin
Password: zrmt123!@#
RTEMS Shell on /dev/pty1088411488. Use 'help' to list commands.
admin@ZXONT00000 [/] # ver
    onu/omci stack version: ZXTZR-V0.32 (build 12127) Dec 12 2023 13:32:25
    pon version: 0.3
    ethc version: 0.3
    image0: ZXTZR-V0.32 valid
    image1: ZXTZR-V0.32 valid active committed next_committed
admin@ZXONT00000 [/] #
admin@ZXONT00000 [/] # tftp 192.168.200.2 ZR00_V090.08
    tftp: socket 31
    downloading .......................
    tftp: total 1454516 bytes received
    tftp: saved to "./ZR00_V090.08"
admin@ZXONT00000 [/] #
admin@ZXONT00000 [/] # ls
    ZR00_V090.08        etc          mnt          tmp dev          firmware     test
admin@ZXONT00000 [/] #
admin@ZXONT00000 [/] # fuse image0 ZR00_V090.08
    verify image...
    file size: 1458176 bytes
    data size: 1456704
    image verified Ok!
    image version: ZR00_V090.08
    image product code: ZXONTXPI
    fuse image
	offset: 0x00080000
	writing .....................................
	fuse done (22309230 usec).
	fuse verify.
	fuse compare done (1607175 usec).
	update done.
admin@ZXONT00000 [/] #
admin@ZXONT00000 [/] # setenv target_image 0
	target_image=0
admin@ZXONT00000 [/] # saveenv
admin@ZXONT00000 [/] # reset
```

# Opsomming van alle commando's
```bash
- tftp 192.168.200.2 ZR00_V090.08
- fuse image0 ZR00_V090.08
- setenv target_image 0	
- saveenv
- reset
```
