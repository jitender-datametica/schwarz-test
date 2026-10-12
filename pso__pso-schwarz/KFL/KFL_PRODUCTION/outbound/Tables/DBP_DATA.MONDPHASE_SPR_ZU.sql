CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mondphase_spr_zu (
mondphase_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
mondphase_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);