CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.order_forecast_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
gp_id BIGNUMERIC(38,0) NOT NULL,
dat_plan DATE NOT NULL,
dat_best DATE NOT NULL,
dispoteilsortiment_id STRING(10) COLLATE 'und:ci',
best_menge_einh_id STRING(3) COLLATE 'und:ci',
basis_menge_einh_id STRING(3) COLLATE 'und:ci',
menge_ofc_ame NUMERIC(18,3),
menge_ofc_bme NUMERIC(18,3),
dat_lief DATE,
banf_beleg_id INTEGER,
best_beleg_id INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);