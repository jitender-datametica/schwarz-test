--==============================================================
-- Table: plantour_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: plantour_1
   generated from Powerdesigner on Monday, March 28, 2022 2:22:32 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.plantour_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
plantour_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Plantournummer'),
tour_id INTEGER OPTIONS(description='Nummer des Transportes (Tour_1)'),
trailer_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen Trailertour'),
trailer_id STRING(10) DEFAULT 'no Lookup' OPTIONS(description='Trailer-ID'),
dat_trailer DATE OPTIONS(description='Übernahmedatum Trailer'),
zeit_trailer TIME OPTIONS(description='Übernahmezeit Trailer'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, plantour_id) NOT ENFORCED
) OPTIONS(description='Plantouren: Kopfdaten');