--==============================================================
-- Table: flw_route_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_route_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_route_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk aus Feld WERK'),
route_id STRING(6) COLLATE 'und:ci' NOT NULL OPTIONS(description='Route aus Feld ROUTE'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
route_bez STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Route aus Feld BEZ'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werk_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Route - SAP FLW (P21) - ZFW_ROUTET');