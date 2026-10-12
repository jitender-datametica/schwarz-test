CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gfk_hhp_wg_account_na_kjmo_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
gfk_account_id BIGNUMERIC(38,0) NOT NULL,
gfk_wg_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(12),
nebenausgaben_anteil BIGNUMERIC(38,5),
nebenausgaben_tsd_eur INTEGER,
nebenausgaben_index BIGNUMERIC(38,5),
td_insert TIMESTAMP,
td_update TIMESTAMP
);