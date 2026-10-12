--==============================================================
-- Table: flw_lagerort_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lagerort_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_lagerort_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Schlüssel für die Lagerorte'),
spr_id BIGNUMERIC(38,0) NOT NULL,
lagerort_bez STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung des Lagerorts'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werk_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Lagerorte aus SAP Industrie t001_2');