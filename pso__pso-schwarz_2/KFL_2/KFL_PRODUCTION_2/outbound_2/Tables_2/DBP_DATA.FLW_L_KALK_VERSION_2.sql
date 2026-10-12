--==============================================================
-- Table: flw_l_kalk_version_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_kalk_version_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_kalk_version_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
kalk_version_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalkulationsversion aus tvers'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kalk_version_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookup zur Version der Kalkulation - SAP P21 TCK32T');