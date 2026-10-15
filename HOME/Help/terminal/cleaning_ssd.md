Controleren of de automatische TRIM actief is
Je kunt in de terminal controleren of Linux wekelijks automatisch TRIMt met dit commando:

Bash
systemctl status fstrim.timer
Als er active (waiting) of active (running) staat, hoef je zelf helemaal niets te doen. Linux regelt het voor je.

2. Handmatig TRIM uitvoeren (als je ongeduldig bent)
Heb je net een enorme map met gigabytes aan data verwijderd en wil je de SSD direct laten opschonen? Dan kun je TRIM handmatig forceren met:

Bash
sudo fstrim -av
(De vlag -a betekent 'alle gekoppelde schijven' en -v staat voor 'verbose', zodat je netjes in de terminal ziet hoeveel gigabytes er zijn opgeschoond).
