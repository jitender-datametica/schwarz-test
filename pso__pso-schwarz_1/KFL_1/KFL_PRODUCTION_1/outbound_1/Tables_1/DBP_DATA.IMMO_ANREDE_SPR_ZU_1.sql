--==============================================================
-- Table: immo_anrede_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_anrede_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_anrede_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
anrede_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID Anrede Partner'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
anrede_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Anrede Partner'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='IMMO - Sprachabhängige Tabelle für die Anrede - SAP REFX - TSAD3T');