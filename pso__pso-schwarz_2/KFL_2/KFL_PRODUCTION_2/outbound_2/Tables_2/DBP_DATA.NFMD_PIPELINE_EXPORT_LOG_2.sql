--==============================================================
-- Table: nfmd_pipeline_export_log_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nfmd_pipeline_export_log_2
   generated from Powerdesigner on Montag, 4. Juli 2022 13:39:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.nfmd_pipeline_export_log_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
execution_tmsp DATETIME NOT NULL OPTIONS(description='timestamp of export execution'),
execution_year BIGNUMERIC(38,0) OPTIONS(description='Year when the process exported data '),
execution_week BIGNUMERIC(38,0) OPTIONS(description='Week of the year when the process exported data'),
sent_rows_cnt BIGNUMERIC(38,0) OPTIONS(description='additive - number of rows send for the export'),
environment_name STRING(50) OPTIONS(description='Environmend where data was sent (ex PROD)'),
erp_guid STRING(36) OPTIONS(description='ID for sending confirmation from the ESB'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, execution_tmsp) NOT ENFORCED
) OPTIONS(description='Information on the export of the approved (reduced) prices for non-food items from DWH  to SAP');