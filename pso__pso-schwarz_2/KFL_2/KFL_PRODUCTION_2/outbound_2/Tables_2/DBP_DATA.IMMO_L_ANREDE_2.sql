--==============================================================
-- Table: immo_l_anrede_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_l_anrede_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_l_anrede_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
anrede_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID Anrede Partner'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='IMMO - Lookup-Tabelle für die Anrede - SAP REFX - TSAD3T');