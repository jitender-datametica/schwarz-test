CREATE OR REPLACE TABLE szd_production_etl.gp_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
gp_id INTEGER NOT NULL OPTIONS(description='Gesch��ftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id INTEGER NOT NULL OPTIONS(description='1000=Warenlieferant 5000=Frischelieferant '),
dat_von DATE OPTIONS(description='Startdatum der Zusammenarbeit'),
dat_bis DATE OPTIONS(description='Ende der G��ltigkeitsperiode. Format JJJJ-MM_2-TT '),
anlieferung_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen der Anerkennung der L&S Anlieferungsbedingungen'),
gp_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Gesch��ftspartners'),
gp_strasse STRING(40) COLLATE 'und:ci' OPTIONS(description='Strasse zur Adresse des Gesch��ftspartners'),
gp_plz STRING(10) COLLATE 'und:ci' OPTIONS(description='Postleitzahl zur Adresse des Gesch��ftspartners'),
gp_ort STRING(40) COLLATE 'und:ci' OPTIONS(description='Ort, an dem der Gesch��ftspartner ans��ssig ist'),
land_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Land_2, in dem sich der Markt befindet. Hat immer L��nge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen, daher in der L��nge 3 '),
hgp_id INTEGER
OPTIONS(description='Nummer des Hauptlieferanten(Kreditors) zu einem Unterlieferanten, i.d.R. die ersten 6 Stellen der siebenstelligen Lieferantennummer'),
zek_id STRING(3)
OPTIONS(description='Zentraleink��ufer - ID des Einkaufsmitarbeiters, der f��r einen Lieferanten zust��ndig ist.'),
lieferzeit INTEGER OPTIONS(description='Standard Lieferzeit in Tagen f��r einen Lieferanten'),
zahlungsziel_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='mit einem Lieferanten vereinbartes Zahlungsziel wird ��ber die Lookup-Tabelle l_zahlungsziel_2 referenziert'),
agb_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Juristische Art_2 der Zusammenarbeit:  L: L&S - AGB G: gesetzliche AGB blank: ohne Angabe'),
iso_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Isonorm, ist der Lieferant nach ISO zertifiziert'),
eigenverpackung_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Kennzeichen f��r Eigenverpackung (J/N)'),
eigenmarke_id STRING(1) COLLATE 'und:ci' OPTIONS(description='handelt es sich um einen Eigenmarken-Lieferanten'),
audit_id STRING(1) COLLATE 'und:ci' OPTIONS(description='M��glichkeit eines Audit'),
audit_dat DATE OPTIONS(description='Datum des letzten Audit. Format JJJJ-MM_2-TT'),
herst_fg INTEGER
OPTIONS(description='Kennzeichnet, ob es sich bei einem Lieferanten gleichzeitig auch um einen Hersteller handelt'),
zahlart_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Eindeutiger Schluessel der Zahlarten, (z. B. m fuer Markant)'),
retour_sperr_fg INTEGER
OPTIONS(description='Dieses Flag kennzeichnet ob der Lieferant f��r Retouren gesperrt ist. FG = 1: Lieferant ist gesperrt.'),
system_id INTEGER OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
gp_branche_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Eindeutiger Schuessel der Lieferantenbranchen (z. B. CO13 fuer Milch, Mopro). In KMO ist die Quelle bsch_id aus t016t, in DE ist die Quelle zzrp_invcat'),
wewa_fg INTEGER
OPTIONS(description='Dieses Flag gibt an, ob es sich bei diesem Lieferanten um einen f��r die wewa_2-Schnittstelle relevanten Gesch��ftspartner handelt'),
loesch_fg INTEGER OPTIONS(description='L��schkennzeichen f��r den Lieferanten (1 ist gel��scht)'),
region_id INTEGER NOT NULL
OPTIONS(description='Region_2 eines Landes, z.Bsp. Hessen, K��rnten. Wird im DWH als k��nstlicher Schl��ssel ��ber die SAP-Region_2 gebildet '),
min_pal_faktor_lkw NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Mindestpalettenfaktor pro LKW aus lfm1.minbw'),
gln_bbnr STRING(10) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Basisnummer der GLN. Quelle ist lfa1.bbbnr'),
gln_bsnr STRING(10) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Individueller Nummernteil der GLN. Quelle ist lfa1.bbsnr'),
gln_bubkz STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Pr��fziffer der GLN. Quelle ist lfa1.bubkz'),
breitengrad BIGNUMERIC(29,16) OPTIONS(description='Breitengrad aus dem GIS-System (Latitude)'),
laengengrad BIGNUMERIC(29,16) OPTIONS(description='L��ngengrad aus dem GIS-System (Longitude)'),
gp_name_lat STRING(80) COLLATE 'und:ci' DEFAULT '0' NOT NULL OPTIONS(description='Lateinische Bezeichnung Lieferant'),
ivn INTEGER OPTIONS(description='Internationale Verhandler Nummer'),
isd_fg INTEGER OPTIONS(description='Flag: Internationale Sortimentsdisposition'),
markant_id STRING(2) DEFAULT '  ' NOT NULL OPTIONS(description='ID Markantabrechnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gp_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Geschaeftspartner - MULTISET');