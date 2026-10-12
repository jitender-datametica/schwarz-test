CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.charge_soll (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
charge_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Chargennummer, analog zu qa_check_og.charge_id - Feld CHARG'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kontonummer des Lieferanten bzw. Kreditors - Feld LIFNR'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer - Feld MATNR'),
dat_von DATE
OPTIONS(description='Sagt aus, ab wann die Charge mit den angegebenen Informationen gültig ist. Eine Charge kann sich im Laufe der Bestellung ändern, dann wird eine neue Chargennummer angelegt - sie wird also neu angelegt und nicht begrenzt. - Feld GILTAB'),
ursprungsland_kbez_soll STRING(4) COLLATE 'und:ci'
OPTIONS(description='Ursprungsland/Länderschlüssel, bspw. DE oder NZ - Feld URZLA'),
zus_ursprungslaender_kbez_soll STRING(16) COLLATE 'und:ci'
OPTIONS(description='weitere Ursprungslänger/Sign O+G, bspw. BE, GR oder NL - Feld SIGNO'),
kollifaktor NUMERIC(18,3)
OPTIONS(description='Kollifaktor, bspw. 10,000 oder 8,000, ist im SOLL (ZOG_CHAR) und IST (ZLV_QA_OG_ACT) identisch - Feld KOLLI'),
palettenfaktor_soll BIGNUMERIC(38,0)
OPTIONS(description='Pallettenfaktor/Menge in Paletten, bspw. 100 oder 60 - Feld MENGEP'),
kontrollnotwendigkeit_vorerntenummer_soll_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag für QS, sagt aus ob Vorerntenummer kontrolliert werden soll - Feld VORERNTE'),
vertragsanbau_soll_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag das aussagt, ob es Vertragsanbau geben soll - Feld CONTRACT_FRAMING'),
nationale_produktion_soll_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag das aussagt, ob Produkt einer nationalen Produktion unterliegen soll - Feld NATIONAL_PROD'),
handelsklasse_soll_kz STRING(1) COLLATE 'und:ci'
OPTIONS(description='Information zur Handelsklasse, bspw. 0  für HKL0, 1 für HKL1,… - Feld HKL'),
unbehandelt_soll_kz STRING(1) COLLATE 'und:ci'
OPTIONS(description='KZ das angibt, ob O&G behandelt oder unbehandelt sein soll, bspw. U für unbehandelt - Feld KZBEH'),
transport_verpackung_kmo_soll_kz STRING(2) COLLATE 'und:ci'
OPTIONS(description='Zweistelliges KZ über Transportverpackung, bspw. KA für Karton - Feld KZPACK'),
kaliber_von_soll BIGNUMERIC(38,0) OPTIONS(description='Kaliber, Größe, Gewicht von, bspw. 800 - Feld KALVON'),
kaliber_bis_soll BIGNUMERIC(38,0) OPTIONS(description='Kaliber, Größe, Gewicht bis, bspw. 1000 - Feld KALBIS'),
einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='(Bestellmengen-)Einheit, bspw. ST oder KG - Feld BSTME'),
freitext_besonderheiten_soll STRING(30) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Besonderheiten (SOLL), z.B. bei einer Mango - Ist sie vorgereift? Kann das Stück auch mal mehr als 250 Gramm haben? - Feld TEXT'),
freitext_transport_verpackung_de_soll STRING(15) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Transportverpackung, nur für DE gefüllt, bspw. LIN oder KARTON - Feld VERPACKTRANS'),
gp_charge_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='Lieferantenchargennummer, unterscheidet sich von der KFL Chargennummer charge_id, ist im SOLL (ZOG_CHAR) und IST (ZLV_QA_OG_ACT) identisch - Feld LICHN'),
gtin_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag das aussagt, ob eine GTIN vorhanden ist, ist im SOLL (ZOG_CHAR) und IST (ZLV_QA_OG_ACT) identisch - Feld GTIN_VORHANDEN'),
charge_vorhanden_soll_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag das aussagt, ob eine Charge vorhanden sein soll - Feld CHARGE_VORHANDEN'),
freitext_temperatur_check_soll STRING(20) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Temperatur mit der die Ware ankommen soll - Feld TEMPERATURE'),
freitext_fruchtfleischdruck_soll STRING(30) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Sagt aus, wie fest Fruchtfleisch sein soll wenn man die Frucht eindrückt - Feld DRUCK (SAP-Feld wurde früher für etwas anderes genutzt (früher wurden Preise auf das Etikett angedrückt), Feldname wurde in SAP nie angepasst)'),
freitext_saftgehalt_soll STRING(30) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Sagt etwas über den Saftgehalt des Artikels aus - Feld REGIONAL_PACK (SAP-Feld wurde früher für etwas anderes genutzt, Feldname wurde in SAP nie angepasst)'),
freitext_lieferanten_kommentar_soll STRING(180) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Information für den Lieferant (SOLL) - Feld KOMMENTAR_LIEFERANT'),
nettoinhalt_kolli_soll NUMERIC(18,3)
OPTIONS(description='Freitextfeld: Durchführung Stichprobe (SOLL) - Sind in 500g Schale auch 500g enthalten? Bei Artikeln ohne Prüfmöglichkeit/Prüfung steht hier eine 0 - Feld NTGEW'),
freitext_primaerverpackung_soll STRING(30) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Verpackung, wie sie im Laden für den Kunden stehen soll - Feld KUNDEN_PACK'),
freitext_qa_kommentar_soll STRING(180) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Information für den Einkauf - Feld KOMMENTAR_QS'),
freitext_marke_soll STRING(60) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Marke des Artikels (SOLL) - Feld MARKE'),
freitext_fruchtgehalt_soll STRING(20) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Zuckergehalt des Artikels - Feld SALES_UNIT'),
kaliber_kz_soll STRING(4) COLLATE 'und:ci'
OPTIONS(description='Kaliber des Produktes SOLL: Größe, Gewicht o.Ä. - Feld CALIBER_UNIT'),
freitext_spezifikation_soll STRING(110) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Spezifikation - Feld Spezifikation'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='SAP RET INTEGER ZOG_CHAR - enthält die O&G Chargenwerte, die durch den EK definiert und bestellt wurden (SOLL), z.B. Äpfel in der Größe 80mm - ZLV_QA_OG_ACT bzw. charge_ist_qa_og bildet das IST ab');