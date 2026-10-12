CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_avq_werbezeitraum_abw_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
werbe_typ_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
kommentar STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);