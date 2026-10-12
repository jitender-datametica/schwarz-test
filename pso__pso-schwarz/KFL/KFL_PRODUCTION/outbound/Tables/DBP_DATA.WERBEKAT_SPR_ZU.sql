CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.werbekat_spr_zu (
werbe_kat_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
werbe_kat_bez STRING(60) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);