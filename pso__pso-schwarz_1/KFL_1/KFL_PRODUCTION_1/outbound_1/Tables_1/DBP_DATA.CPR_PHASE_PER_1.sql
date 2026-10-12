--==============================================================
-- Table: cpr_phase_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_phase_per_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_phase_per_1 (
projekt_phase_id STRING(32) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige ID einer Projektphase aus xlcphase'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
projekt_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID des Projekts'),
cpr_ext_id STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='zusätzliche ID pro Projekt / Phase'),
dat_freigabe DATE OPTIONS(description='Datum der Freigabe'),
einzel_massnahme STRING(30) COLLATE 'und:ci' OPTIONS(description='Einelmassnahme'),
teil_massnahme_id STRING(30) COLLATE 'und:ci' OPTIONS(description='eindeutige ID der Teilmassnahme'),
teil_massn_kz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kennzeichen zur Teil-Massnahme. Enthält Werte von 1 bis 4'),
cpr_systemstatus1_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus1, Enthält numerische Werte von 1 aufsteigend'),
cpr_systemstatus2_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus2.  Enthält numerische Werte von 1 aufsteigend'),
cpr_systemstatus3_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus3.  Enthält numerische Werte von 1 aufsteigend'),
phasenart_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Schlüssel der Phasenart, z.Bsp P7-Planung'),
cpr_suchfeld_id BIGNUMERIC(38,0)
OPTIONS(description='Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert'),
cpr_phase_version_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='Version (Kundenfeld) einer Phase aus zz_ppo_version. Inhalt z.Bsp. 1.1'),
cpr_phase_version_dat DATE OPTIONS(description='Datum_ab einer Version aus zz_ppo_datum_vom'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat_von) NOT ENFORCED
) OPTIONS(description='IOS - Projektphase');