CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.marktbestand_erp_delta_1 (
art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
menge_lgbest_erp_frei_bme NUMERIC(18,3) NOT NULL,
menge_lgbest_erp_qual_bme NUMERIC(18,3) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);