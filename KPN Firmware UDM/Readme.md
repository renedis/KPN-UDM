# Zaram firmware
Voor het gebruik met KPN is een specifieke firmware-upgrade vereist. Dit betreft een officiële firmware die speciaal is ontwikkeld voor KPN NL. Hoewel deze firmware-upgrade ook werkt op het Delta-netwerk, is dit niet strikt noodzakelijk. Het flashen van de firmware kan volledig worden uitgevoerd op de UDM Pro (SE/Max) zelf, of via een Unifi-switch met een SFP+ poort in combinatie met de UDM Pro (SE/Max).

De firmware dient men via eigen kanalen te bemachtigen. Deze kan momenteel niet worden voorzien via dit kanaal. 
De KPN NL versie betreft ZR00_V090.08

## SFP Upgrade Instructions

To upgrade your SFP, follow the steps below:

**Connect to the SFP**: 
   - Use SSH to connect to the SFP.
   - SFP Address: `192.168.200.1`
   - Client Address: `192.168.200.2`

**Login Credentials**:
   - Username: `admin`
   - Password: `zrmt123!@#`

**Upgrade Procedure**:
   ```shell
   tftp 192.168.200.2 ZR00_V090.08
   fuse image0 ZR00_V090.08
   setenv target_image 0
   saveenv
   reset
   ```

## Detailed steps

```bash
/dev/pty1088411488 login: admin
Password: zrmt123!@#
RTEMS Shell on /dev/pty1088411488. Use 'help' to list commands.
admin@ZXONT04RNN [/] # ver
    onu/omci stack version: ZXTZR-V0.32 (build 12127) Dec 12 2023 13:32:25
    pon version: 0.3
    ethc version: 0.3
    image0: ZXTZR-V0.32 valid
    image1: ZXTZR-V0.32 valid active committed next_committed
admin@ZXONT04RNN [/] #
admin@ZXONT04RNN [/] # tftp 192.168.200.2 ZR00_V090.08
    tftp: socket 31
    downloading .......................
    tftp: total 1454516 bytes received
    tftp: saved to "./ZR00_V090.08"
admin@ZXONT04RNN [/] #
admin@ZXONT04RNN [/] # ls
    ZR00_V090.08        etc          mnt          tmp dev          firmware     test
admin@ZXONT04RNN [/] #
admin@ZXONT04RNN [/] # fuse image0 ZR00_V090.08
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
admin@ZXONT04RNN [/] #
admin@ZXONT04RNN [/] # setenv target_image 0
	target_image=0
admin@ZXONT04RNN [/] # saveenv
admin@ZXONT04RNN [/] # reset
```

# Summary of all commands
```bash
- tftp 192.168.200.2 ZR00_V090.08
- fuse image0 ZR00_V090.08
- setenv target_image 0	
- saveenv
- reset
```
