CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sb_grund_spr_zu (
sb_grund_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
sb_grund_bez STRING(80) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);