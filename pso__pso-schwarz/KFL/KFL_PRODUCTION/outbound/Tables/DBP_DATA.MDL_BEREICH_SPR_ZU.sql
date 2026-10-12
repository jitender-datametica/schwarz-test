CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mdl_bereich_spr_zu (
bereich_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
bereich_bez STRING(80) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);