CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.profil_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
profil_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
profil_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);