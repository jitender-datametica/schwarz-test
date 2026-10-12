CREATE TABLE IF NOT EXISTS kfl_nfmd_core.sap_pipeline_writeback (
mandant_id BIGNUMERIC(38,0),
year BIGNUMERIC(38,0),
week BIGNUMERIC(38,0),
num_sent_rows BIGNUMERIC(38,0),
environment STRING(16777216),
erp_guid STRING(16777216),
timestamp DATETIME
);