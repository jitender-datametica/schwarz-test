--==============================================================
-- Table: in_l_einkaeufer_int_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_einkaeufer_int_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_einkaeufer_int_1 (
einkaeufer_int_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des internationalen Einkäufers aus dem SAP-Klassensystem, z.Bsp I14'),
einkaeufer_int_name STRING(50) COLLATE 'und:ci' OPTIONS(description='Name des internationalen Einkäufers'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='BIS - internationaler Einkäufer aus dem SAP Klassensystem. Dem Lieferanten zugeordneter internationaler Einkäufer');