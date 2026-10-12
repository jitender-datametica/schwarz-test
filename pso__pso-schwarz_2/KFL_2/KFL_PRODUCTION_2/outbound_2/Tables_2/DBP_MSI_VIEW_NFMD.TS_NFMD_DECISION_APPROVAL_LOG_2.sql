--==============================================================
-- Table: ts_nfmd_decision_approval_log_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_decision_approval_log_2
   generated from Powerdesigner on Montag, 4. Juli 2022 13:42:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_nfmd.ts_nfmd_decision_approval_log_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dwh_created_tmsp DATETIME NOT NULL OPTIONS(description='timestamp when the record was created'),
kjwo_ww BIGNUMERIC(38,0) OPTIONS(description='Calendar_2 year-week when the promotion campaign started. Format JJJJWW'),
user_id STRING(255) OPTIONS(description='AD name of the user who created the record'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dwh_created_tmsp) NOT ENFORCED
)
OPTIONS(description='Log table for approval of the price reduction decision per calendar_2 week, client - populated by Frontend');