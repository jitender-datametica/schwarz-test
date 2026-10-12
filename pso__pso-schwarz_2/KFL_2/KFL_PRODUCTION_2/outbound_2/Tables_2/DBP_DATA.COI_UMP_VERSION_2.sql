CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.coi_ump_version_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
gj_plan BIGNUMERIC(38,0) NOT NULL,
version_id BIGNUMERIC(38,0) NOT NULL,
datzeit_upload DATETIME NOT NULL,
dat_planwerte_ist_ab DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);