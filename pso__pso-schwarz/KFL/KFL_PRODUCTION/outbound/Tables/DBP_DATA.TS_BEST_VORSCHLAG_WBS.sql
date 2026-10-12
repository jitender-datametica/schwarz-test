CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_best_vorschlag_wbs (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
dat_ausfuehrung DATE NOT NULL,
menge_wbs_final NUMERIC(18,4) NOT NULL,
check_vz_fg BIGNUMERIC(38,0) NOT NULL,
check_wup_fg BIGNUMERIC(38,0) NOT NULL,
status_verarbeitung BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);