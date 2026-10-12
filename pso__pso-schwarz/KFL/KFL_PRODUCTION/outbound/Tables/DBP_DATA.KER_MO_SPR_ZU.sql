CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ker_mo_spr_zu (
ker_mo_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
ker_mo_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);