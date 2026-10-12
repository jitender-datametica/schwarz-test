--==============================================================
-- Table: disposition_rhythmus_ltf_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: disposition_rhythmus_ltf_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.disposition_rhythmus_ltf_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
disposition_rhythmus_ltf_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID für den Dispositionsrhythmus (wie oft, an welchen Wochentagen)'),
disposition_rhythmus_ltf_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung für den Dispositionsrhythmus (wie oft, an welchen Wochentagen)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='LIS - Sprachabhängige Bezeichnungen für den Dispositionsrhythmus - SAP RET - ZRS_DISPORHYTHMT');