CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_nutzung (
mandant_id BIGNUMERIC(38,0) NOT NULL,
nutzung_id BIGNUMERIC(38,0) NOT NULL,
nutzung_bez STRING(30) COLLATE 'und:ci',
spr_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);