CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_verkettung_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wg_verkett_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
wg_verkett_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);