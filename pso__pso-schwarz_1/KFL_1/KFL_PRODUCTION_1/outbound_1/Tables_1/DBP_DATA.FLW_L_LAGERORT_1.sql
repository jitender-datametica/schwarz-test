--==============================================================
-- Table: flw_l_lagerort_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_lagerort_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_lagerort_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Schlüssel für die Lagerorte'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werk_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookup-Tabelle der Lagerorte aus SAP Industrie t001_1');