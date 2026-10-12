--==============================================================
-- Table: gp
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:10:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gp (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='1000=Warenlieferant 5000=Frischelieferant '),
dat_von DATE OPTIONS(description='Startdatum der Zusammenarbeit'),
dat_bis DATE OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT '),
anlieferung_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen der Anerkennung der L&S Anlieferungsbedingungen'),
gp_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Geschäftspartners'),
gp_strasse STRING(40) COLLATE 'und:ci' OPTIONS(description='Strasse zur Adresse des Geschäftspartners'),
gp_plz STRING(10) COLLATE 'und:ci' OPTIONS(description='Postleitzahl zur Adresse des Geschäftspartners'),
gp_ort STRING(40) COLLATE 'und:ci' OPTIONS(description='Ort, an dem der Geschäftspartner ansässig ist'),
land_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Land, in dem sich der Markt befindet. Hat immer Länge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen, daher in der Länge 3 '),
hgp_id BIGNUMERIC(38,0)
OPTIONS(description='Nummer des Hauptlieferanten(Kreditors) zu einem Unterlieferanten, i.d.R. die ersten 6 Stellen der siebenstelligen Lieferantennummer'),
zek_id STRING(3)
OPTIONS(description='Zentraleinkäufer - ID des Einkaufsmitarbeiters, der für einen Lieferanten zuständig ist.'),
lieferzeit BIGNUMERIC(38,0) OPTIONS(description='Standard Lieferzeit in Tagen für einen Lieferanten'),
zahlungsziel_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='mit einem Lieferanten vereinbartes Zahlungsziel wird über die Lookup-Tabelle l_zahlungsziel referenziert'),
agb_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Juristische Art der Zusammenarbeit:  L: L&S - AGB G: gesetzliche AGB blank: ohne Angabe'),
iso_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Isonorm, ist der Lieferant nach ISO zertifiziert'),
eigenverpackung_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Kennzeichen für Eigenverpackung (J/N)'),
eigenmarke_id STRING(1) COLLATE 'und:ci' OPTIONS(description='handelt es sich um einen Eigenmarken-Lieferanten'),
audit_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Möglichkeit eines Audit'),
audit_dat DATE OPTIONS(description='Datum des letzten Audit. Format JJJJ-MM-TT'),
herst_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichnet, ob es sich bei einem Lieferanten gleichzeitig auch um einen Hersteller handelt'),
zahlart_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Eindeutiger Schluessel der Zahlarten, (z. B. m fuer Markant)'),
retour_sperr_fg BIGNUMERIC(38,0)
OPTIONS(description='Dieses Flag kennzeichnet ob der Lieferant für Retouren gesperrt ist. FG = 1: Lieferant ist gesperrt.'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
gp_branche_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Eindeutiger Schuessel der Lieferantenbranchen (z. B. CO13 fuer Milch, Mopro). In KMO ist die Quelle bsch_id aus t016t, in DE ist die Quelle zzrp_invcat'),
wewa_fg BIGNUMERIC(38,0)
OPTIONS(description='Dieses Flag gibt an, ob es sich bei diesem Lieferanten um einen für die wewa-Schnittstelle relevanten Geschäftspartner handelt'),
loesch_fg BIGNUMERIC(38,0) OPTIONS(description='Löschkennzeichen für den Lieferanten (1 ist gelöscht)'),
region_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Region eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region gebildet '),
min_pal_faktor_lkw NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Mindestpalettenfaktor pro LKW aus lfm1.minbw'),
gln_bbnr STRING(10) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Basisnummer der GLN. Quelle ist lfa1.bbbnr'),
gln_bsnr STRING(10) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Individueller Nummernteil der GLN. Quelle ist lfa1.bbsnr'),
gln_bubkz STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Prüfziffer der GLN. Quelle ist lfa1.bubkz'),
breitengrad BIGNUMERIC(38,16) OPTIONS(description='Breitengrad aus dem GIS-System (Latitude)'),
laengengrad BIGNUMERIC(38,16) OPTIONS(description='Längengrad aus dem GIS-System (Longitude)'),
gp_name_lat STRING(80) COLLATE 'und:ci' DEFAULT '0' NOT NULL OPTIONS(description='Lateinische Bezeichnung Lieferant'),
ivn BIGNUMERIC(38,0) OPTIONS(description='Internationale Verhandler Nummer'),
isd_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Internationale Sortimentsdisposition'),
markant_id STRING(2) DEFAULT '  ' NOT NULL OPTIONS(description='ID Markantabrechnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gp_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Geschaeftspartner - MULTISET');