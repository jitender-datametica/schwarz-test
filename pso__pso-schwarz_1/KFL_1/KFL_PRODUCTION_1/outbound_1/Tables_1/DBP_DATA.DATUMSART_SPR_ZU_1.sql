--==============================================================
-- Table: datumsart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: datumsart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.datumsart_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK - Mandant_1 im DWH'),
datumsart_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Datumsart, z.Bsp. 13'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
datumsart_bez STRING(50) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Datumsart, z.Bsp. Beginn Wehrdienst'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='SHR - Sprachabhängige Bezeichnung der Ereignisse');