CREATE OR REPLACE TABLE kfl_production_dbp_data.rpm_immobilie_per (
rpm_hierarchie_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID der Immobilie'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gueltig ist'),
techn_platz_id STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der technische Platz ist eine von Kaufland Facility Management verwaltete Einheit'),
vs_id INTEGER NOT NULL OPTIONS(description='Referenz zur Vertriebsschiene aus zppm_konzept'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
gesamtbew_note NUMERIC(9,2) OPTIONS(description='Gesamtbewertung Durchschnittsnote aus zppm_gesamtbew'),
bewertungszahl_a NUMERIC(9,2) OPTIONS(description='Bewertungszahl aus zppm_bew_zahl_a'),
bewertungszahl_b NUMERIC(9,2) OPTIONS(description='Bewertungszahl aus zppm_bew_zahl_b'),
bewertungszahl_c NUMERIC(9,2) OPTIONS(description='Bewertungszahl aus zppm_bew_zahl_c'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gueltig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
gj_umbvorschl INTEGER OPTIONS(description='Umbauvorschlag - Geschaeftsjahr aus zppm_umbvorschl'),
wup_id INTEGER OPTIONS(description='Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wup_standort STRING(40) COLLATE 'und:ci' OPTIONS(description='Standort aus zppm_standort'),
strasse STRING(80) COLLATE 'und:ci' OPTIONS(description='Strasse des Objekts aus zppm_strasse'),
plz STRING(10) COLLATE 'und:ci' OPTIONS(description='Postleitzahl aus zppm_plz'),
zielumsatz_3gj NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Zielumsatz im dritten GJ aus zppm_zielumsatz'),
dat_eroeffn_fb_imm DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Datum Eroeffnung Festbau Immobilie aus zppm_er_fbau_imm'),
uebernahme_von STRING(40) COLLATE 'und:ci' OPTIONS(description='uebernahmefirma aus zppm_uebernfirm'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='RPM - Informationen zu einer Immobilie (IST) aus inm_initiative');