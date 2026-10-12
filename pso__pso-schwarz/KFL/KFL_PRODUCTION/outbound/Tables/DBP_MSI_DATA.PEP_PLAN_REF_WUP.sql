CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.pep_plan_ref_wup (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
ref_wup_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);