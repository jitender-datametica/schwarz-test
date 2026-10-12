CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_buchungsperiode (
buchungsperiode_id BIGNUMERIC(38,0) NOT NULL,
gj_variante_id STRING(2) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
buchungsperiode_bez STRING(30) COLLATE 'und:ci',
krk_id STRING(4) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);