CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ssm_cluster_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_bereich_id BIGNUMERIC(38,0) NOT NULL,
wup_abt_id BIGNUMERIC(38,0) NOT NULL,
ssm_cluster_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
ssm_cluster_bez STRING(80) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);