--==============================================================
-- Table: flw_kalk_version_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_version_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kalk_version_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
kalk_version_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalkulationsversion aus tvers'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
kalk_version_bez STRING(30) DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung der Kalkulationsversion'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kalk_version_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnung der Kalkulationsversion - SAP P21 TCK32T');