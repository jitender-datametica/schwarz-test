CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mitbew_wup (
mitbew_wup_id BIGNUMERIC(38,0),
mitbew_grp_id STRING(2) COLLATE 'und:ci',
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
mitbew_name STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);