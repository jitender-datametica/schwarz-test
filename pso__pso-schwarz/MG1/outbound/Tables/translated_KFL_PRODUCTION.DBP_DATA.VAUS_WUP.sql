CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.VAUS_WUP (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer aus t001w.werks'),
VS_ID INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ID der Vertriebsschiene. Vertriebssicht auf die WUP-Objekte'),
LAND_ID STRING(8) DEFAULT '  ' NOT NULL
OPTIONS(description='Land, in dem sich der Markt befindet. Hat immer Länge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen '),
REGION_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Region eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region gebildet. Quelle ist t001w.bundesland '),
WUP_PLZ STRING(40) DEFAULT ' ' NOT NULL OPTIONS(description='Postleitzahl aus adrc.postcode1'),
WUP_STADT_1 STRING(320) DEFAULT ' ' NOT NULL OPTIONS(description='Stadt (Adresse) aus city_1'),
WUP_STR STRING(320) DEFAULT ' ' NOT NULL OPTIONS(description='Strasse (Adresse) aus street'),
WUP_NAME_1 STRING(320) DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung des Marktes aus name'),
WUP_NAME_2 STRING(320) OPTIONS(description='Bezeichnung (abweichend von postalischer Adresse) aus adrc.name1'),
SYSTEM_ID INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
BUCHUNGSKREIS_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001.'),
WUP_TELEFON STRING(80) OPTIONS(description='Telefonnummer aus telf1'),
WUP_FAX STRING(80) OPTIONS(description='Faxnummer aus telfx'),
DAT_EROEFFNUNG DATE DEFAULT CAST('1970-01-01' AS DATE) NOT NULL
OPTIONS(description='\"Echtes\" Eröffnungsdatum des Marktes. Quelle?'),
DAT_SCHLIESSUNG DATE DEFAULT CAST('1970-01-01' AS DATE) NOT NULL OPTIONS(description='Schließungsdatum. Quelle ?'),
BETRIEBSRAT_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Wird aus Tabelle zrs_vsdata versorgt. Ermittlung noch ?'),
NILS_VERTEILGEBIET_ID INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Verteilgebiet. Quelle noch ?'),
AUFLAGE_WUP_VERTEILGEBIET INTEGER NOT NULL OPTIONS(description='Auflage im Verteilgebiet des Marktes. Quelle noch ?'),
AUFLAGE_WUP_AUSLAGE INTEGER
OPTIONS(description='Anzahl der dem Markt zur Verfügung gestellten Exemplare. Quelle noch ?'),
GLN_ID STRING(80) DEFAULT ' ' NOT NULL
OPTIONS(description='Global Location Number - international  eindeutige Kennzeichnung der Lokation. Quelle ist KNA1 (Retail) mit den Feldern bbbnr(Basisnummer), bbsnr(Individueller Nummernteil) und bubkz(Prüfziffer)'),
KUNDE_ID STRING(40) DEFAULT '          ' NOT NULL
OPTIONS(description='Kundennummer des Marktes. Entspricht der Marktnummer mit führenden Nullen'),
TD_INSERT TIMESTAMP,
TD_UPDATE TIMESTAMP
) OPTIONS(description='VIS - Stammdaten für den WarenUmschlagsPlatz aus den Quellen csks, t001w, adrc');
