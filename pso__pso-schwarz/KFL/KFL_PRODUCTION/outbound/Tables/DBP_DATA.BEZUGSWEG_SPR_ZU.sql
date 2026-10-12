--==============================================================
-- Table: bezugsweg_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bezugsweg_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bezugsweg_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
bezugsweg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
bezugsweg_bez STRING(30) COLLATE 'und:ci' OPTIONS(description='Sprachabhängige Bezeichnung des Bezugswegs'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bezugsweg_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Sprachabhängige Bezeichnung des Bezugswegs');