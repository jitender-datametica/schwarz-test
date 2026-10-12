--==============================================================
-- Table: ts_belos_adresse_wup_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_belos_adresse_wup_zu
   generated from Powerdesigner on Friday, May 6, 2022 4:01:22 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_belos_adresse_wup_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
belos_adresse_id STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schluessel zur Identifikation einer BELOS Adresse.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID, wird verwendet fuer Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stellen der Marktnummer, die Nebenbetriebskennziffer.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id) NOT ENFORCED
) OPTIONS(description='Zuordnung BELOS-Adresse zu wup_id (wird fuer BELOS-Adressen der VZ genutzt).');