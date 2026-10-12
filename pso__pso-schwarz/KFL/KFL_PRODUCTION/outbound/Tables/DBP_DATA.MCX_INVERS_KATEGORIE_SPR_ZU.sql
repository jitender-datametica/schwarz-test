CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_invers_kategorie_spr_zu (
invers_kat_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
invers_kat_bez STRING(150) COLLATE 'und:ci',
invers_kat_bez_2 STRING(150) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);