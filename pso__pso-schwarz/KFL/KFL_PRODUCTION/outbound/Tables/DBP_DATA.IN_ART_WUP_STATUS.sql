CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_art_wup_status (
in_art_id BIGNUMERIC(38,0) NOT NULL,
werk_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
einkaeufer_grp_id STRING(3) COLLATE 'und:ci',
in_dispomerkmal STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);