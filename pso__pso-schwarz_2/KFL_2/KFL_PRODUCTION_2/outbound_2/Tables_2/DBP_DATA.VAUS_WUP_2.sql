CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vaus_wup_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer aus t001w.werks'),
vs_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='ID der Vertriebsschiene. Vertriebssicht auf die WUP_2-Objekte'),
land_id STRING(8) DEFAULT '  ' NOT NULL
OPTIONS(description='Land_2, in dem sich der Markt befindet. Hat immer Länge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen '),
region_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Region_2 eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region_2 gebildet. Quelle ist t001w.bundesland '),
wup_plz STRING(40) DEFAULT ' ' NOT NULL OPTIONS(description='Postleitzahl aus adrc.postcode1'),
wup_stadt_1 STRING(320) DEFAULT ' ' NOT NULL OPTIONS(description='Stadt (Adresse) aus city_1'),
wup_str STRING(320) DEFAULT ' ' NOT NULL OPTIONS(description='Strasse (Adresse) aus street'),
wup_name_1 STRING(320) DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung des Marktes aus name'),
wup_name_2 STRING(320) OPTIONS(description='Bezeichnung (abweichend von postalischer Adresse) aus adrc.name1'),
system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
buchungskreis_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001.'),
wup_telefon STRING(80) OPTIONS(description='Telefonnummer aus telf1'),
wup_fax STRING(80) OPTIONS(description='Faxnummer aus telfx'),
dat_eroeffnung DATE DEFAULT CAST('2090-12-31' AS DATE) NOT NULL
OPTIONS(description='\"Echtes\" Eröffnungsdatum des Marktes. Quelle?'),
dat_schliessung DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL OPTIONS(description='Schließungsdatum. Quelle ?'),
betriebsrat_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Wird aus Tabelle zrs_vsdata versorgt. Ermittlung noch ?'),
nils_verteilgebiet_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Verteilgebiet. Quelle noch ?'),
auflage_wup_verteilgebiet BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Auflage im Verteilgebiet des Marktes. Quelle noch ?'),
auflage_wup_auslage BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der dem Markt zur Verfügung gestellten Exemplare. Quelle noch ?'),
gln_id STRING(80) DEFAULT ' ' NOT NULL
OPTIONS(description='Global Location_2 Number - international  eindeutige Kennzeichnung der Lokation. Quelle ist KNA1_2 (Retail) mit den Feldern bbbnr(Basisnummer), bbsnr(Individueller Nummernteil) und bubkz(Prüfziffer)'),
kunde_id STRING(40) DEFAULT '          ' NOT NULL
OPTIONS(description='Kundennummer des Marktes. Entspricht der Marktnummer mit führenden Nullen'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='VIS - Stammdaten für den WarenUmschlagsPlatz aus den Quellen csks, t001w_2, adrc_2');