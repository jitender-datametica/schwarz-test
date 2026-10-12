CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.platzierungswg_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
platzierungswg_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
platzierungswg_bez STRING(50) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);