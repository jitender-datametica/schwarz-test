CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fur_best_vor (
best_vor_id BIGNUMERIC(38,0) NOT NULL,
best_vor_pos_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat_dispo DATE NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
gp_id BIGNUMERIC(38,0) NOT NULL,
menge_best_vor NUMERIC(9,3) NOT NULL,
dat_lief_soll DATE NOT NULL,
best_vor_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
push_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
iwt_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, dat_dispo;