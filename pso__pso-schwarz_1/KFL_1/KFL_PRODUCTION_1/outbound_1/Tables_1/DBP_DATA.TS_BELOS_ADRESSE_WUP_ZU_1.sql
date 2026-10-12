--==============================================================
-- Table: ts_belos_adresse_wup_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_belos_adresse_wup_zu_1
   generated from Powerdesigner on Friday, May 6, 2022 4:01:22 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_belos_adresse_wup_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
belos_adresse_id STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schluessel zur Identifikation einer BELOS Adresse.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID, wird verwendet fuer Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stellen der Marktnummer, die Nebenbetriebskennziffer.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id) NOT ENFORCED
) OPTIONS(description='Zuordnung BELOS-Adresse zu wup_id (wird fuer BELOS-Adressen der VZ genutzt).');