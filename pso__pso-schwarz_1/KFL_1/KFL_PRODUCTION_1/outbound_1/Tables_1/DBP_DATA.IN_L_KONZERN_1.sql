--==============================================================
-- Table: in_l_konzern_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_konzern_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_konzern_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
konzern_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Konzerns'),
konzern_name STRING(50) COLLATE 'und:ci' NOT NULL OPTIONS(description='Name des Konzerns'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, konzern_id) NOT ENFORCED
) OPTIONS(description='BIS - der Konzern ist eine_1 Gruppierung über Lieferanten. Quelle ist das SAP - Klassensystem');