--==============================================================
-- Table: ts_nfmd_manual_price_release_log
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_manual_price_release_log
   generated from Powerdesigner on Montag, 4. Juli 2022 13:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_nfmd.ts_nfmd_manual_price_release_log (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
dwh_created_tmsp DATETIME NOT NULL OPTIONS(description='timestamp when the record was created'),
kjwo_ww BIGNUMERIC(38,0) OPTIONS(description='Calendar year-week when the promotion campaign started. Format JJJJWW'),
user_id STRING(255) OPTIONS(description='AD name of the user who created the record'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dwh_created_tmsp) NOT ENFORCED
) OPTIONS(description='Approval of the changed prices & their validity per calendar week, client');