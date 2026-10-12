CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.fmard_de_initial (
mandant_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
dat DATE,
bestand_id BIGNUMERIC(38,0),
bezugsweg_id BIGNUMERIC(38,0),
relevant_fg BIGNUMERIC(38,0),
menge_lgbest_erp_frei_bme NUMERIC(18,3),
menge_lgbest_erp_qual_bme NUMERIC(18,3),
fortschreibung_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP,
menge_lgbest_erp_gesp_bme NUMERIC(18,3)
);