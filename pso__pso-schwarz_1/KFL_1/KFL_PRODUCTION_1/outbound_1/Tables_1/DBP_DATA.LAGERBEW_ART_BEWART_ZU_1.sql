CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerbew_art_bewart_zu_1 (
art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_buch_first DATE NOT NULL,
dat_buch_last DATE NOT NULL,
dat_erfasst_first DATE NOT NULL,
dat_erfasst_last DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id;