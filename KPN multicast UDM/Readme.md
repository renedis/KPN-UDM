# Multicast
De standaardmethode voor het instellen van multicast is niet voldoende effectief. Dit komt doordat de UDM Pro (SE/Max) standaard geen optimale ondersteuning biedt voor multicast. Er zijn aanvullende stappen nodig om multicast correct te configureren, zodat het soepel en betrouwbaar functioneert.

## Installeren script

De standaard ingebouwde IGMP proxy van de UDM Pro (SE/Max) werkt helaas niet goed. Om tot een goede werking van multicast te komen moeten er aanvullende acties plaatsen vinden. Dit moet via SSH uitgevoerd worden. Houd er rekening mee dat je Zaram SFP+ verbinding al werkt/actief is!
De ingebouwde versie heeft benaming improxy, we dienen de standaard igmpproxy package te installeren. Voor gemaks doeleinde installeren we ook de nano package. Ter info: Ten alle tijden dient het vinkje in de Unifi WebGUI uit te blijven.

# Waarom IGMPPROXY en niet IMPROXY
Zowel de packages 'improxy' als 'igmpproxy' bieden de basisfunctionaliteit voor IGMP-proxying. Echter, improxy is de standaard UDM pre-geïnstalleerde package, die gekoppeld is aan de standaardinstellingen van het apparaat. Als u de ETH8 Ethernet-verbinding gebruikt, is improxy voldoende. Echter, bij gebruik van de ETH9 Fiber-verbinding, kan improxy problemen veroorzaken vanwege compatibiliteitskwesties met de software/firmware van de UDM zelf. Daarom is het noodzakelijk om de 'igmpproxy' package van de standaard Debian repository te installeren.

### 1. SSH - Installeer packages
Voer de volgende opdracht uit om de benodigde packages te installeren:
```bash
apt-update && apt install nano igmpproxy
```

### 2. SSH - Installeer UDM-IPTV script
Als eerste, alle credits voor dit script gaan naar @fabianishere.

Installeer het one line install script met de volgende opdracht:
```bash
sh -c "$(curl https://raw.githubusercontent.com/fabianishere/udm-iptv/master/install.sh -sSf)"
```
Volg vervolgens de gevraagde stappen. Een tip: ``UDM Pro (SE/Max) SFP+ WAN = ETH9``

### 3. SSH - Configureren van udm-iptv.conf
Ook het script maakt gebruik van improxy in plaats van het igmpproxy-pakket. De juiste package hebben we eerder geïnstalleerd. Pas nu het conf-bestand aan met de volgende opdracht: ``"nano /etc/udm-iptv.conf"``

Pas het aan naar onderstaande waardes. Let op! ``"IPTV_LAN_INTERFACES="br4"`` is de enige variabele die ik niet voor jou kan bepalen. Dit is namelijk de bridge waar multicast op je lokale LAN moet werken. Als je het script van @fabianishere hebt uitgevoerd staat dit waarschijnlijk al goed.

```bash
IPTV_WAN_INTERFACE="eth9"
IPTV_WAN_VLAN="4"
IPTV_WAN_VLAN_INTERFACE="iptv"
IPTV_WAN_RANGES="213.75.0.0/16  217.166.0.0/16"
IPTV_WAN_DHCP_OPTIONS="-O staticroutes -V IPTV_RG"
IPTV_LAN_INTERFACES="br4"
IPTV_IGMPPROXY_DISABLE_QUICKLEAVE="false"
IPTV_IGMPPROXY_DEBUG="true"
IPTV_IGMPPROXY_PROGRAM="igmpproxy"
IPTV_IGMPPROXY_IGMP_VERSION="2"
```

### 4. SSH - Herstart de IPTV service

Om de instellingen actief te maken dienen we de service te herstarten met:
```bash
systemctl restart udm-iptv
```

### 5. Unifi WebGUI - Multicast DNS en IGMP Snooping
Controleer in de WebGUI van je UDM Pro (SE/Max) of de volgende instellingen aan staan bij ``Instellingen > Networks``

- ``Multicast DNS`` *Op het Subnet van IPTV waar je STB op aangesloten zit.
- ``IGMP Snooping`` *Op het subnet van IPTV waar je STB op aangesloten zit.

### 6. Wachten op toepassen op netwerk
Geduld is een schone zaak. Wanneer je alleen een UDM Pro (SE/Max) in je netwerk hebt naast clients, zullen de instellingen snel worden toegepast. Echter, wanneer je een groter netwerk hebt met meerdere switches, kan het toepassen van de instellingen veel langer duren. Houd rekening met een verwerkingstijd van 20 tot 30 minuten.

Het is belangrijk op te merken dat een reboot om het proces te versnellen geen effect zal hebben. Het systeem heeft tijd nodig om de wijzigingen door te voeren en deze te verspreiden naar alle aangesloten apparaten.


### Disclaimer: Alles op Eigen Risico
De informatie op deze pagina('s) / in dit document wordt verstrekt als algemene informatie. Hoewel we ons best doen om de informatie actueel en juist te houden, kunnen we geen garanties geven over de volledigheid, nauwkeurigheid, betrouwbaarheid, geschiktheid of beschikbaarheid ervan met betrekking tot de pagina('s) of de informatie, producten, diensten of gerelateerde afbeeldingen die op de website voor welk doel dan ook worden aangeboden.

Elk vertrouwen dat je stelt in deze informatie is strikt op eigen risico. Wij zijn niet aansprakelijk voor enig verlies of schade, inclusief maar niet beperkt tot indirecte of gevolgschade, of enig verlies of schade die voortvloeit uit het verlies van gegevens of winsten die voortvloeien uit of in verband met het gebruik van deze pagina('s).

Door deze pagina('s) te gebruiken, ga je ermee akkoord dat je de volledige verantwoordelijkheid aanvaardt voor het gebruik van deze informatie en stem je ermee in om ons niet aansprakelijk te stellen voor enige claims die voortvloeien uit je gebruik van deze pagina('s).

De informatie op deze pagina('s) / in deze documenten is niet bedoeld als vervanging voor professioneel advies. Raadpleeg altijd een gekwalificeerde professional voor specifieke adviezen.
