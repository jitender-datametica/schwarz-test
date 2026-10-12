--==============================================================
-- Table: disponent_wup_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: disponent_wup_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.disponent_wup_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
disponent_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Disponent ID'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
disponent_name STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der Name des Disponenten ist von wup_2 abhängig. Das Feld wird daher aus der Tabelle l_disponent_2 in diese Tabelle verschoben.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id) NOT ENFORCED
) OPTIONS(description='TP408 LVS - Zuordnung Disponent zum Markt - MULTISET');