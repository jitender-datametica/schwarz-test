--==============================================================
-- Table: ts_personalteilbereich_wup_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_personalteilbereich_wup_zu_2
   generated from Powerdesigner on Montag, 22. August 2022 13:18:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_personalteilbereich_wup_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
personalteilbereich_id STRING(4) NOT NULL
OPTIONS(description='Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, personalteilbereich_id, wup_id) NOT ENFORCED
) OPTIONS(description='Zuordnung Personalteilbereich (Hydra) zu Verteilzentrum');