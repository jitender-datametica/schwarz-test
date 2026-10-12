--==============================================================
-- Table: altersteilzeit_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: altersteilzeit_spr_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.altersteilzeit_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK - Mandant im DWH'),
atz_phase_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Phase im Blockmodell. Gibt an, in welcher Phase sich der MA befindet, z.Bsp. BF'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
atz_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Altersteilzeit-Phase'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='SHR - Sprachabhängige Bezeichnung der Altersteilzeit-Phasen');