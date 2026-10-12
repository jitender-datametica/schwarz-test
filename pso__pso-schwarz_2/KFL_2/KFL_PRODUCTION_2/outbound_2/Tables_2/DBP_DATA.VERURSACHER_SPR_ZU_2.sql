CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.verursacher_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
verursacher_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
verursacher_bez STRING(40) COLLATE 'und:ci',
system_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);