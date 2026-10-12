CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.GP_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
EINKAUFSORGANISATION_ID INTEGER NOT NULL OPTIONS(description='1000=Warenlieferant 5000=Frischelieferant '),
DAT_VON DATE OPTIONS(description='Startdatum der Zusammenarbeit'),
DAT_BIS DATE OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT '),
ANLIEFERUNG_ID STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen der Anerkennung der L&S Anlieferungsbedingungen'),
GP_NAME STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Geschäftspartners'),
GP_STRASSE STRING(40) COLLATE 'und:ci' OPTIONS(description='Strasse zur Adresse des Geschäftspartners'),
GP_PLZ STRING(10) COLLATE 'und:ci' OPTIONS(description='Postleitzahl zur Adresse des Geschäftspartners'),
GP_ORT STRING(40) COLLATE 'und:ci' OPTIONS(description='Ort, an dem der Geschäftspartner ansässig ist'),
LAND_ID STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Land_2, in dem sich der Markt befindet. Hat immer Länge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen, daher in der Länge 3 '),
HGP_ID INTEGER
OPTIONS(description='Nummer des Hauptlieferanten(Kreditors) zu einem Unterlieferanten, i.d.R. die ersten 6 Stellen der siebenstelligen Lieferantennummer'),
ZEK_ID STRING(3)
OPTIONS(description='Zentraleinkäufer - ID des Einkaufsmitarbeiters, der für einen Lieferanten zuständig ist.'),
LIEFERZEIT INTEGER OPTIONS(description='Standard Lieferzeit in Tagen für einen Lieferanten'),
ZAHLUNGSZIEL_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='mit einem Lieferanten vereinbartes Zahlungsziel wird über die Lookup-Tabelle l_zahlungsziel_2 referenziert'),
AGB_ID STRING(1) COLLATE 'und:ci'
OPTIONS(description='Juristische Art_2 der Zusammenarbeit:  L: L&S - AGB G: gesetzliche AGB blank: ohne Angabe'),
ISO_ID STRING(4) COLLATE 'und:ci' OPTIONS(description='Isonorm, ist der Lieferant nach ISO zertifiziert'),
EIGENVERPACKUNG_ID STRING(1) COLLATE 'und:ci' OPTIONS(description='Kennzeichen für Eigenverpackung (J/N)'),
EIGENMARKE_ID STRING(1) COLLATE 'und:ci' OPTIONS(description='handelt es sich um einen Eigenmarken-Lieferanten'),
AUDIT_ID STRING(1) COLLATE 'und:ci' OPTIONS(description='Möglichkeit eines Audit'),
AUDIT_DAT DATE OPTIONS(description='Datum des letzten Audit. Format JJJJ-MM_2-TT'),
HERST_FG INTEGER
OPTIONS(description='Kennzeichnet, ob es sich bei einem Lieferanten gleichzeitig auch um einen Hersteller handelt'),
ZAHLART_ID STRING(1) COLLATE 'und:ci'
OPTIONS(description='Eindeutiger Schluessel der Zahlarten, (z. B. m fuer Markant)'),
RETOUR_SPERR_FG INTEGER
OPTIONS(description='Dieses Flag kennzeichnet ob der Lieferant für Retouren gesperrt ist. FG = 1: Lieferant ist gesperrt.'),
SYSTEM_ID INTEGER OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
GP_BRANCHE_ID STRING(4) COLLATE 'und:ci'
OPTIONS(description='Eindeutiger Schuessel der Lieferantenbranchen (z. B. CO13 fuer Milch, Mopro). In KMO ist die Quelle bsch_id aus t016t, in DE ist die Quelle zzrp_invcat'),
WEWA_FG INTEGER
OPTIONS(description='Dieses Flag gibt an, ob es sich bei diesem Lieferanten um einen für die wewa_2-Schnittstelle relevanten Geschäftspartner handelt'),
LOESCH_FG INTEGER OPTIONS(description='Löschkennzeichen für den Lieferanten (1 ist gelöscht)'),
REGION_ID INTEGER NOT NULL
OPTIONS(description='Region_2 eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region_2 gebildet '),
MIN_PAL_FAKTOR_LKW NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Mindestpalettenfaktor pro LKW aus lfm1.minbw'),
GLN_BBNR STRING(10) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Basisnummer der GLN. Quelle ist lfa1.bbbnr'),
GLN_BSNR STRING(10) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Individueller Nummernteil der GLN. Quelle ist lfa1.bbsnr'),
GLN_BUBKZ STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Prüfziffer der GLN. Quelle ist lfa1.bubkz'),
BREITENGRAD BIGNUMERIC(29,16) OPTIONS(description='Breitengrad aus dem GIS-System (Latitude)'),
LAENGENGRAD BIGNUMERIC(29,16) OPTIONS(description='Längengrad aus dem GIS-System (Longitude)'),
GP_NAME_LAT STRING(80) COLLATE 'und:ci' DEFAULT '0' NOT NULL OPTIONS(description='Lateinische Bezeichnung Lieferant'),
IVN INTEGER OPTIONS(description='Internationale Verhandler Nummer'),
ISD_FG INTEGER OPTIONS(description='Flag: Internationale Sortimentsdisposition'),
MARKANT_ID STRING(2) DEFAULT '  ' NOT NULL OPTIONS(description='ID Markantabrechnung'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, GP_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Geschaeftspartner - MULTISET');