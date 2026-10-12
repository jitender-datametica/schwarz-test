CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_kategorie_spr_zu_2 (
kat_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kat_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);