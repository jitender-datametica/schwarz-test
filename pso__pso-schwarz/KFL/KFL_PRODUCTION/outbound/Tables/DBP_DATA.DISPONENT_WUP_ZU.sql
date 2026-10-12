--==============================================================
-- Table: disponent_wup_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: disponent_wup_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.disponent_wup_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
disponent_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Disponent ID'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
disponent_name STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der Name des Disponenten ist von wup abhängig. Das Feld wird daher aus der Tabelle l_disponent in diese Tabelle verschoben.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id) NOT ENFORCED
) OPTIONS(description='TP408 LVS - Zuordnung Disponent zum Markt - MULTISET');