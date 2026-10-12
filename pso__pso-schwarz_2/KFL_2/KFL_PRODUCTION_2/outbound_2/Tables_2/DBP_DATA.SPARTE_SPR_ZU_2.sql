CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sparte_spr_zu_2 (
sparte_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
sparte_bez STRING(30) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);