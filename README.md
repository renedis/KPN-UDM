# KPN NL Fiber <--> Zaram SFP+ <--> UDM-Pro (SE/Max)
De onderstaande instructies hebben tot doel richtlijnen te verschaffen voor het flashen van de Zaram firmware en het correct configureren van multicast op de UDM Pro (SE/Max). Het is tevens waarschijnlijk dat andere producten in de Unifi-lijn met een SFP+ poort vergelijkbare functionaliteit ondersteunen, hoewel ik hier geen specifieke ervaringen mee heb.

###
## Zaram firmware
Voor het gebruik met KPN is een specifieke firmware-upgrade vereist. Dit betreft een officiële firmware die speciaal is ontwikkeld voor KPN NL. Hoewel deze firmware-upgrade ook werkt op het Delta-netwerk, is dit niet strikt noodzakelijk. Het flashen van de firmware kan volledig worden uitgevoerd op de UDM Pro (SE/Max) zelf, of via een Unifi-switch met een SFP+ poort in combinatie met de UDM Pro (SE/Max).

De firmware dient men via eigen kanalen te bemachtigen. Deze kan momenteel niet worden voorzien via dit kanaal. De KPN NL versie betreft ZR00_V090.08

###
## Multicast
De standaardmethode voor het instellen van multicast is niet voldoende effectief. Dit komt doordat de UDM Pro (SE/Max) standaard geen optimale ondersteuning biedt voor multicast. Er zijn aanvullende stappen nodig om multicast correct te configureren, zodat het soepel en betrouwbaar functioneert.

###
###

### Disclaimer: Alles op Eigen Risico

<sup>De informatie op deze pagina('s) / in dit document wordt verstrekt als algemene informatie. Hoewel we ons best doen om de informatie actueel en juist te houden, kunnen we geen garanties geven over de volledigheid, nauwkeurigheid, betrouwbaarheid, geschiktheid of beschikbaarheid ervan met betrekking tot de pagina('s) of de informatie, producten, diensten of gerelateerde afbeeldingen die op de website voor welk doel dan ook worden aangeboden.</sup>

<sup>Elk vertrouwen dat je stelt in deze informatie is strikt op eigen risico. Wij zijn niet aansprakelijk voor enig verlies of schade, inclusief maar niet beperkt tot indirecte of gevolgschade, of enig verlies of schade die voortvloeit uit het verlies van gegevens of winsten die voortvloeien uit of in verband met het gebruik van deze pagina('s).</sup>

<sup>Door deze pagina('s) te gebruiken, ga je ermee akkoord dat je de volledige verantwoordelijkheid aanvaardt voor het gebruik van deze informatie en stem je ermee in om ons niet aansprakelijk te stellen voor enige claims die voortvloeien uit je gebruik van deze pagina('s).</sup>

<sup>De informatie op deze pagina('s) / in deze documenten is niet bedoeld als vervanging voor professioneel advies. Raadpleeg altijd een gekwalificeerde professional voor specifieke adviezen.</sup>

