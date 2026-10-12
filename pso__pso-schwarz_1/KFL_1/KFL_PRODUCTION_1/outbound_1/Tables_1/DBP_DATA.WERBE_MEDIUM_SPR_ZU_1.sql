CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.werbe_medium_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
medien_kz STRING(2) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
werbe_medium_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);