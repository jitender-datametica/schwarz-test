--==============================================================
-- Table: ts_wup_zeit_anlieferung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wup_zeit_anlieferung
   generated from Powerdesigner on Freitag, 5. Januar 2024 08:30:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_wup_zeit_anlieferung_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
transportsortiment_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Transportsortiment ID - concatenation of  Lagersortiment IDs that should be put on the same truck for transportation (for example 27 means Lagersortiment ID 2 and Lagersortiment ID 7 are transported together)'),
dat_von DATE NOT NULL OPTIONS(description='Gültig von'),
dat_bis DATE OPTIONS(description='Gültig bis'),
zeit_anlieferung TIME OPTIONS(description='Ziel-Uhrzeit für Anlieferung TIME'),
zeit_anlieferung_num BIGNUMERIC(38,0)
OPTIONS(description='Ziel-Uhrzeit für Anlieferung NUMBER (time of day formated as HH24MISS and stored as number type)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat_von) NOT ENFORCED
) OPTIONS(description='Table contain exceptions for some stores with target delivery hours different from standard ');