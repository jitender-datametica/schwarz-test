CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ssm_wup_tag_treiber_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
treiber_id BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci',
wert_tag NUMERIC(18,3),
td_insert TIMESTAMP,
td_update TIMESTAMP
);