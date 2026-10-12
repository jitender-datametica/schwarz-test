--==============================================================
-- Table: handling_unit_status_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: handling_unit_status_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.handling_unit_status_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
hu_status_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID Bewegungsstatus der Handling Unit_1'),
hu_status_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung Bewegungsstatus der Handling Unit_1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='LIS - Sprachtabelle Bewegungsstautus Handling Unit_1');