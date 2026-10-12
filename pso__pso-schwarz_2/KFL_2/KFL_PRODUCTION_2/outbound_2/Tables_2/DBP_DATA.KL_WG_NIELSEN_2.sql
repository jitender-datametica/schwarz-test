CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kl_wg_nielsen_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kl_wg_id BIGNUMERIC(38,0) NOT NULL,
kl_art_kat_id BIGNUMERIC(38,0),
kl_wg_bez STRING(100) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);