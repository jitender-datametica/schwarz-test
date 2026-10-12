--==============================================================
-- Table: charge_ist_qa_check
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: charge_ist_qa_check
   generated from Powerdesigner on Mittwoch, 28. Februar 2024 10:48:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.charge_ist_qa_check (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/-komplex - Feld LGNUM'),
tour_id INTEGER NOT NULL
OPTIONS(description='Transportnummer, analog zu VVTK/VTTP.TKNUM bzw. tour/tour_det.tour_id - Feld TKNUM'),
lief_beleg_id INTEGER NOT NULL
OPTIONS(description='Vertriebsbelegnummer, analog zu LIPS.VBELN bzw. besch_lief/besch_lief_det.lief_beleg_id - Feld VBELN'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kontonummer des Lieferanten bzw. Kreditors - Feld LIFNR'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer - Feld MATNR'),
charge_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Chargennummer, analog zu qa_check_og.charge_id - Feld CHARG'),
charge_nr_qa STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Chargennummer, die bei einer QS-Meldung erzeugt wird  / QA steht für O&G, PF für Pflanzen, FL für Fleischwerk -> aber nicht zwingend - Feld CHARG_QA'),
kaliber_kz_ist STRING(4) COLLATE 'und:ci'
OPTIONS(description='Kaliber des Produktes IST: Größe, Gewicht o.Ä. - Feld CALIBER_UNIT'),
freitext_qa_kommentar_ist STRING(180) COLLATE 'und:ci' OPTIONS(description='freitext_qa_kommentar_ist'),
ursprungsland_kbez_ist STRING(4) COLLATE 'und:ci'
OPTIONS(description='Ursprungsland/Länderschlüssel, bspw. DE oder NZ - Feld URZLA'),
zus_ursprungslaender_kbez_ist STRING(16) COLLATE 'und:ci'
OPTIONS(description='weitere Ursprungslänger/Sign O+G, bspw. BE, GR oder NL - Feld SIGNO'),
defekte_kolli_ist BIGNUMERIC(38,0) OPTIONS(description='Anzahl der defekten Kolli - Feld DEFECT_KOLLIS'),
handelsklasse_ist_kz STRING(1) COLLATE 'und:ci'
OPTIONS(description='Information zur Handelsklasse, 0 steht für HKL0, 1 für HKL1,… - Feld HKL'),
freitext_lieferanten_kommentar_ist STRING(180) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Information für den Lieferant (IST) / Vorgabe vom Einkäufer an den Lieferanten und damit Inhalt, der im WE geprüft wird - Feld KOMMENTAR_LIEFERANT'),
freitext_primaerverpackung_ist STRING(30) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Verpackung, wie sie im Laden für den Kunden steht - Feld KUNDEN_PACK'),
unbehandelt_ist_kz STRING(1) COLLATE 'und:ci'
OPTIONS(description='KZ das angibt, ob O&G behandelt oder unbehandelt ist, bspw. U für unbehandelt - Feld KZBEH'),
transport_verpackung_kmo_ist_kz STRING(2) COLLATE 'und:ci'
OPTIONS(description='Zweistelliges KZ über Transportverpackung, bspw. KA für Karton - Feld KZPACK'),
freitext_marke_ist STRING(60) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Marke des Artikels (IST) - Feld MARKE'),
menge_stichprobe_frischemaengel NUMERIC(18,3)
OPTIONS(description='Wieviel Stück / KG wurden in der Stichprobe mit Frischemangel gefunden - Feld AMOUNT_DEFECT_MAJOR '),
menge_stichprobe_sonstiges NUMERIC(18,3)
OPTIONS(description='Wieviel Stück / KG wurden in der Stichprobe mit sonstigen Mängeln gefunden - Feld AMOUNT_DEFECT_MINOR'),
nettoinhalt_kolli_ist NUMERIC(18,3)
OPTIONS(description='Durchführung Stichprobe (IST) - Sind in 500g Schale auch 500g enthalten? Bei Artikeln ohne Prüfmöglichkeit/Prüfung steht hier eine 0 - Feld NTGEW'),
freitext_fruchtfleischdruck_ist STRING(30) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Sagt aus, wie fest Fruchtfleisch ist wenn man die Frucht eindrückt - Feld DRUCK (SAP-Feld wurde früher für etwas anderes genutzt (früher wurden Preise auf das Etikett angedrückt), Feldname wurde in SAP nie angepasst)'),
freitext_produzent_ist STRING(30) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Produzent des Artikels (IST) - Feld PRODUCER'),
freitext_hinweis_fuer_qa_ist STRING(110) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Hinweis für den Kontrolleur - Feld QA_COMMENT'),
freitext_saftgehalt_ist STRING(30) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Sagt etwas über den Saftgehalt des Artikels aus - Feld REGIONAL_PACK (SAP-Feld wurde früher für etwas anderes genutzt, Feldname wurde in SAP nie angepasst)'),
anz_kolli_geprueft_ist BIGNUMERIC(38,0) OPTIONS(description='Anzahl der geprüften Kolli - Feld SAMPLE_KOLLIS'),
freitext_spezifikation_ist STRING(110) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Spezifikation - Feld Spezifikation'),
freitext_temperatur_check_ist STRING(20) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Temperatur mit der die Ware ankommt - Feld TEMPERATURE'),
freitext_besonderheiten_ist STRING(30) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Besonderheiten (IST), z.B. bei einer Mango - Ist sie vorgereift? Kann das Stück auch mal mehr als 250 Gramm haben? - Feld TEXT'),
freitext_transport_verpackung_de_ist STRING(15) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Transportverpackung, nur für DE gefüllt, bspw. LIN oder KARTON - Feld VERPACKTRANS'),
kontrollnotwendigkeit_vorerntenummer_ist_fg BIGNUMERIC(38,0) DEFAULT ROUND(CAST('0' AS BIGNUMERIC), 0) NOT NULL
OPTIONS(description='Flag für QS, sagt aus ob Vorerntenummer kontrolliert wurde - Feld VORERNTE'),
palettenfaktor_ist BIGNUMERIC(38,0)
OPTIONS(description='Pallettenfaktor/Menge in Paletten, bspw. 100 oder 60 - Feld MENGEP'),
vertragsanbau_ist_fg BIGNUMERIC(38,0) DEFAULT ROUND(CAST('0' AS BIGNUMERIC), 0) NOT NULL
OPTIONS(description='Flag das aussagt, ob es Vertragsanbau gibt - Feld CONTRACT_FRAMING'),
nationale_produktion_ist_fg BIGNUMERIC(38,0) DEFAULT ROUND(CAST('0' AS BIGNUMERIC), 0) NOT NULL
OPTIONS(description='Flag das aussagt, ob Produkt einer nationalen Produktion unterliegt - Feld NATIONAL_PROD'),
kaliber_von_ist BIGNUMERIC(38,0) OPTIONS(description='Kaliber, Größe, Gewicht von, bspw. 800 - Feld KALVON'),
kaliber_bis_ist BIGNUMERIC(38,0) OPTIONS(description='Kaliber, Größe, Gewicht bis, bspw. 1000 - Feld KALBIS'),
freitext_fruchtgehalt_ist STRING(20) COLLATE 'und:ci'
OPTIONS(description='Freitextfeld: Zuckergehalt des Artikels - Feld SALES_UNIT'),
dat_empfang DATE OPTIONS(description='Empfangsdatum - Feld RECEIVE_DATE'),
dat_antwort DATE OPTIONS(description='Antwortdatum - Feld RESPONSE_DATE'),
zeit_antwort TIMESTAMP OPTIONS(description='Antwortzeit - Feld RESPONSE_DATE'),
dat_aenderung DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Änderungsdatum, Datum an dem der Satz hinzugefügt wurde - Feld AEDAT'),
anz_kolli NUMERIC(18,3) OPTIONS(description='Anzahl Kolli - Feld KOLLI'),
qa_status STRING(2) COLLATE 'und:ci'
OPTIONS(description='QA Status, bspw. A für Konzession, R für Verweigerung, S für Annahme - Feld QA_STATUS'),
anz_kolli_ist BIGNUMERIC(38,0) OPTIONS(description='Kollianzahl IST- Feld QA_MENGEP'),
charge_vorhanden_ist_fg BIGNUMERIC(38,0) DEFAULT ROUND(CAST('0' AS BIGNUMERIC), 0) NOT NULL
OPTIONS(description='Flag, das aussagt, ob eine Charge vorhanden ist - Feld CHARGE_VORHANDEN'),
lieferant_charge_nr STRING(15) OPTIONS(description='Lieferantenchargennummer'),
gtin_vorhanden_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag, welche aussagt, ob eine GTIN für den Artikel vorhanden (1) ist oder nicht (0).'),
datzeit_eingang TIMESTAMP OPTIONS(description='Eingangszeitstempel der QA-Meldung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, tour_id, lief_beleg_id, gp_id, art_id) NOT ENFORCED
)
OPTIONS(description='SAP RET INTEGER ZLV_QA_OG_ACT - enthält die O&G Chargenwerte, die an das VZ geliefert werden (IST), z.B. Äpfel in der Größe 75mm - ZOG_CHAR bzw. charge_ist bildet das SOLL ab');